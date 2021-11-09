using Microsoft.AspNetCore.SignalR;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using Microsoft.AspNetCore.Http;
using ChatLife.Dto;
using ChatLife.Models;
using ChatLife.Services;

namespace ChatLife
{
    public class ChatHub : Hub
    {
        public static ConcurrentDictionary<string, string> users = new ConcurrentDictionary<string, string>();
        public static List<dynamic> TypingList = new List<object>();
        protected readonly MyContext context;

        public ChatHub(MyContext context)
        {
            this.context = context;
        }

        public string GetConnectionId()
        {
            return Context.ConnectionId;
        }
        public void AddToConnected(string userCode)
        {
            users.TryAdd(Context.ConnectionId, userCode);
        }

        public override Task OnConnectedAsync()
        {

            return base.OnConnectedAsync();
        }

        public void SendActiveFriends(string userSession)
        {
            List<UserDto> active = new List<UserDto>();
            List<UserDto> friends = this.context.Contacts
                     .Where(x => x.UserCode.Equals(userSession) || x.ContactCode.Equals(userSession))
                     .OrderBy(x => x.UserContact.FullName)
                     .Select(x => new UserDto()
                     {
                         Avatar = x.UserContact.Avatar,
                         Code = x.UserContact.Code,
                         FullName = x.UserContact.FullName,
                         Address = x.UserContact.Address,
                         Dob = x.UserContact.Dob,
                         Email = x.UserContact.Email,
                         Gender = x.UserContact.Gender,
                         Phone = x.UserContact.Phone
                     }).ToList();
            foreach (var s in users.Values)
            {
                var exists = friends.Any(x => x.Code == s);
                if (exists)
                {
                    var fr = friends.Where(x => x.Code == s).Select(x => new UserDto
                    {

                        Code = x.Code,
                        FullName = x.FullName,
                        Avatar = x.Avatar,

                    }).FirstOrDefault();
                    active.Add(fr);
                }
            }
            var dataSend = new
            {
                connectionId = Context.ConnectionId,
                userCode = userSession,
                Type = "GetActiveList",
                active = active,
            };
            base.Clients.Client(Context.ConnectionId).SendAsync("GetActiveFriends", dataSend);
        }
        public override Task OnDisconnectedAsync(Exception exception)
        {
            string user;
            users.TryRemove(Context.ConnectionId, out user);
            return base.OnDisconnectedAsync(exception);
        }

        public void IsTyping(string groupCode, string username, string Code, string Avatar)
        {
            var data = new
            {
                GroupCode = groupCode,
                UserName = username,
                Code = Code,
                Avatar = Avatar,
            };
            try
            {
                if (!TypingList.Contains(data))
                {
                    TypingList.Add(data);
                }
                /*                var json = JsonConvert.SerializeObject(TypingList);
                */
                var updateUnreadUser = this.context.GroupUsers.Where(x => x.GroupCode == groupCode && x.UserCode == Code).FirstOrDefault();
                if (updateUnreadUser != null)
                {
                    updateUnreadUser.Unread = 0;
                    this.context.SaveChanges();
                }
                base.Clients.All.SendAsync("IsTyping", TypingList);
            }
            catch (Exception ex)
            {

            }
        }

        public void NotIsTyping(string groupCode, string username, string Code, string Avatar)
        {
            var data = new
            {
                GroupCode = groupCode,
                UserName = username,
                Code = Code,
                Avatar = Avatar,
            };
            try
            {

                TypingList.RemoveAll(x => x.Code == Code);

                /*                var json = JsonConvert.SerializeObject(TypingList);
                */
                var updateUnreadUser = this.context.GroupUsers.Where(x => x.GroupCode == groupCode && x.UserCode == Code).FirstOrDefault();
                if (updateUnreadUser != null)
                {
                    updateUnreadUser.Unread = 0;
                    this.context.SaveChanges();
                }
                base.Clients.All.SendAsync("IsTyping", TypingList);
            }
            catch (Exception ex)
            {

            }
        }

        public void SeenMessage(long messageId, string userCode, string groupCode)
        {
            var check = this.context.MessageSeens.Any(x => x.MessageId == messageId && x.UserCode == userCode);
            if (!check)
            {
                DateTime dateNow = DateTime.Now;

                MessageSeen msgSeen = new MessageSeen()
                {
                    MessageId = messageId,
                    UserCode = userCode,
                    GroupCode = groupCode,
                    Created = dateNow,
                };
                this.context.MessageSeens.Add(msgSeen);
                this.context.SaveChanges();
            }
            var messageSeens = this.context.MessageSeens.Where(x => x.MessageId == messageId).Select(x => new
            {
                FullName = x.User.FullName,
                Avatar = x.User.Avatar,
                Created = x.Created,
            }).ToList();
            var dataReturn = new
            {
                MessageId = messageId,
                messageSeens = messageSeens,
                type = "messageSeens"
            };
            base.Clients.All.SendAsync("MessageSeen", dataReturn);
        }


    }
}
