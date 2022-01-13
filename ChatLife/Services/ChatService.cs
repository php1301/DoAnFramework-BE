using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using RestSharp;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using ChatLife.Dto;
using ChatLife.Models;
using ChatLife.Utils;


namespace ChatLife.Services
{
    public class ChatService
    {
        protected readonly MyContext context;
        protected IHubContext<ChatHub> chatHub;
        protected readonly IWebHostEnvironment hostEnvironment;

        public ChatService(MyContext context, IWebHostEnvironment hostEnvironment, IHubContext<ChatHub> chatHub)
        {
            this.context = context;
            this.chatHub = chatHub;
            this.hostEnvironment = hostEnvironment;
        }

        /// <summary>
        /// Danh sách lịch sử chat
        /// </summary>
        /// <param name="userSession">User hiện tại đang đăng nhập</param>
        /// <returns>Danh sách lịch sử chat</returns>
        public List<GroupDto> GetHistory(string userSession)
        {
            // lấy danh sách nhóm chat
            List<GroupDto> groups = this.context.Groups
                     .Where(x => x.GroupUsers.Any(y => y.UserCode.Equals(userSession)))
                     .Select(x => new GroupDto()
                     {
                         Code = x.Code,
                         Name = x.Name,
                         Avatar = x.Avatar,
                         Type = x.Type,
                         LastActive = x.LastActive,
                         Users = x.GroupUsers.Select(y => new UserDto()
                         {
                             Code = y.User.Code,
                             FullName = y.User.FullName,
                             Avatar = y.User.Avatar
                         }).ToList(),
                         Unread = x.GroupUsers.Where(y => y.UserCode == userSession).Select(y => y.Unread).FirstOrDefault()
                     }).ToList();

            foreach (var group in groups)
            {
                var tempCode = group.Code;
                //Nếu nhóm chat có type = SINGLE (chat 1-1) => đổi tên nhóm chat thành tên người chat cùng
                if (group.Type == Constants.GroupType.SINGLE)
                {
                    var us = group.Users.FirstOrDefault(x => !x.Code.Equals(userSession));
                    group.Name = us?.FullName;
                    group.Avatar = us?.Avatar;
                }

                // Lấy tin nhắn gần nhất để hiển thị
                group.LastMessage = this.context.Messages
                    .Where(x => x.GroupCode.Equals(tempCode))
                    .OrderByDescending(x => x.Created)
                    .Select(x => new MessageDto()
                    {
                        Id = x.Id,
                        Created = x.Created,
                        CreatedBy = x.CreatedBy,
                        Content = x.Content,
                        GroupCode = x.GroupCode,
                        isRemoved = x.isRemoved,
                        Type = x.Type,
                        UserCreatedBy = new UserDto
                        {
                            FullName = x.UserCreatedBy.FullName
                        }
                    }).FirstOrDefault();
            }

            return groups.OrderByDescending(x => x.LastActive)
                     .ToList();
        }
        /// <summary>
        /// Thông tin nhóm chat
        /// </summary>
        /// <param name="userSession">User hiện tại đang đăng nhập</param>
        /// <param name="groupCode">Mã nhóm</param>
        /// <param name="contactCode">Người chat</param>
        /// <returns></returns>
        public object GetInfo(string userSession, string groupCode, string contactCode)
        {
            // Láy thông tin nhóm chat
            Group group = this.context.Groups.FirstOrDefault(x => x.Code.Equals(groupCode));

            // nếu mã nhóm k tồn tại => thuộc loại chat 1-1 (Tự quy định) => Trả về thông tin người chat cùng
            if (group == null)
            {
                string grpCode = this.context.Groups
                    .Where(x => x.Type.Equals(Constants.GroupType.SINGLE))
                    .Where(x => x.GroupUsers.Any(y => y.UserCode.Equals(userSession) &&
                                x.GroupUsers.Any(y => y.UserCode.Equals(contactCode))))
                    .Select(x => x.Code)
                    .FirstOrDefault();
                return this.context.Users
                        .Where(x => x.Code.Equals(contactCode))
                        .OrderBy(x => x.FullName)
                        .Select(x => new
                        {
                            IsGroup = false,
                            Code = grpCode,
                            Address = x.Address,
                            Avatar = x.Avatar,
                            UserCode = x.Code,
                            Dob = x.Dob,
                            Email = x.Email,
                            FullName = x.FullName,
                            Gender = x.Gender,
                            Phone = x.Phone,
                            UserName = x.UserName,
                        })
                        .FirstOrDefault();
            }
            else
            {
                // Nếu tồn tại nhóm chat + nhóm chat có type = SINGLE (Chat 1-1) => trả về thông tin người chat cùng
                if (group.Type.Equals(Constants.GroupType.SINGLE))
                {
                    string userCode = group.GroupUsers.FirstOrDefault(x => x.UserCode != userSession)?.UserCode;
                    return this.context.Users
                            .Where(x => x.Code.Equals(userCode))
                            .OrderBy(x => x.FullName)
                            .Select(x => new
                            {
                                IsGroup = false,
                                Code = groupCode,
                                Address = x.Address,
                                Avatar = x.Avatar,
                                UserCode = x.Code,
                                Dob = x.Dob,
                                Email = x.Email,
                                FullName = x.FullName,
                                Gender = x.Gender,
                                Phone = x.Phone,
                                UserName = x.UserName,
                            })
                             .FirstOrDefault();
                }
                else
                {
                    // Nếu tồn tại nhóm chat + nhóm chat nhiều người => trả về thông tin nhóm chat + thành viên trong nhóm
                    return new
                    {
                        IsGroup = true,
                        Code = group.Code,
                        Avatar = group.Avatar,
                        Name = group.Name,
                        Type = group.Type,
                        Users = group.GroupUsers
                            .OrderBy(x => x.User.FullName)
                            .Select(x => new UserDto()
                            {
                                Code = x.User.Code,
                                FullName = x.User.FullName,
                                Avatar = x.User.Avatar
                            }).ToList()
                    };
                }
            }
        }

        /// <summary>
        /// Thêm mới nhóm chat
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="group">Nhóm</param>
        public void AddGroup(string userCode, GroupDto group)
        {
            DateTime dateNow = DateTime.Now;
            Group grp = new Group()
            {
                Code = Guid.NewGuid().ToString("N"),
                Name = group.Name,
                Created = dateNow,
                CreatedBy = userCode,
                Type = Constants.GroupType.MULTI,
                LastActive = dateNow,
                Avatar = Constants.AVATAR_DEFAULT
            };

            List<GroupUser> groupUsers = group.Users.Select(x => new GroupUser()
            {
                UserCode = x.Code
            }).ToList();

            groupUsers.Add(new GroupUser()
            {
                UserCode = userCode
            });

            grp.GroupUsers = groupUsers;

            this.context.Groups.Add(grp);
            this.context.SaveChanges();
        }


        public void RemoveMessage(string userCode, int messageId, string groupCode)
        {
            try
            {
                var message = this.context.Messages.Where(x => x.Id == messageId).FirstOrDefault();
                if (message.CreatedBy == userCode)
                {
                    message.isRemoved = 2;
                    this.context.SaveChanges();
                    var usersInGroup = this.context.GroupUsers.Where(x => x.GroupCode == groupCode).ToList();
                    foreach (var us in usersInGroup)
                    {
                        var data = new
                        {
                            type = "sync"
                        };
                        if (us.User.CurrentSession != null)
                        {
                            this.chatHub.Clients.Client(us.User.CurrentSession).SendAsync("SyncSignal", data);
                        }
                    }
                }
            }
            catch (Exception ex)
            {

            }
        }
        /// <summary>
        /// Cập nhật ảnh đại diện của nhóm chat
        /// </summary>
        /// <param name="group">Nhóm</param>
        /// <returns></returns>
        public GroupDto UpdateGroupAvatar(GroupDto group)
        {
            Group grp = this.context.Groups
                .FirstOrDefault(x => x.Code == group.Code);

            if (grp != null)
            {
                if (group.Avatar.Contains("data:image/png;base64,"))
                {
                    string pathAvatar = $"Resource/Avatar/{Guid.NewGuid().ToString("N")}";
                    string pathFile = Path.Combine(this.hostEnvironment.ContentRootPath, pathAvatar);
                    DataHelper.Base64ToImage(group.Avatar.Replace("data:image/png;base64,", ""), pathFile);
                    grp.Avatar = group.Avatar = pathAvatar;
                }
                this.context.SaveChanges();
            }
            return group;
        }
        /// <summary>
        /// Gửi tin nhắn
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="groupCode">Mã nhóm</param>
        /// <param name="message">Tin nhắn</param>
        public void SendMessage(string userCode, string groupCode, MessageDto message)
        {
            // Lấy thông tin nhóm chat
            Group grp = this.context.Groups.FirstOrDefault(x => x.Code.Equals(groupCode));
            DateTime dateNow = DateTime.Now;

            // Nếu nhóm không tồn tại => cố gắng lấy thông tin nhóm đã từng chat giữa 2 người
            if (grp == null)
            {
                string grpCode = this.context.Groups
                    .Where(x => x.Type.Equals(Constants.GroupType.SINGLE))
                    .Where(x => x.GroupUsers.Any(y => y.UserCode.Equals(userCode) &&
                                x.GroupUsers.Any(y => y.UserCode.Equals(message.SendTo))))
                    .Select(x => x.Code)
                    .FirstOrDefault();

                grp = this.context.Groups.FirstOrDefault(x => x.Code.Equals(grpCode));
            }

            // Nếu nhóm vẫn không tồn tại => tạo nhóm chat mới có 2 thành viên
            if (grp == null)
            {
                User userSent = this.context.Users.FirstOrDefault(x => x.Code.Equals(userCode));
                User sendTo = this.context.Users.FirstOrDefault(x => x.Code.Equals(message.SendTo));
                grp = new Group()
                {
                    Code = Guid.NewGuid().ToString("N"),
                    Name = sendTo.FullName,
                    Created = dateNow,
                    CreatedBy = userCode,
                    Type = Constants.GroupType.SINGLE,
                    GroupUsers = new List<GroupUser>()
                        {
                            new GroupUser()
                            {
                                UserCode = userCode,
                                User = userSent
                            },
                            new GroupUser()
                            {
                                UserCode = sendTo.Code,
                                Unread = 1,
                                User = sendTo
                            }
                        }
                };
                this.context.Groups.Add(grp);
            }

            // Nếu tin nhắn có file => lưu file
            if (message.Attachments != null && message.Attachments.Count > 0)
            {
                string path = Path.Combine(this.hostEnvironment.ContentRootPath, $"Resource/Attachment/{DateTime.Now.Year}");
                FileHelper.CreateDirectory(path);
                try
                {
                    if (message.Attachments[0].Length > 0)
                    {
                        string pathFile = path + "/" + message.Attachments[0].FileName;
                        if (!File.Exists(pathFile))
                        {
                            using (var stream = File.Create(pathFile))
                            {
                                message.Attachments[0].CopyTo(stream);
                            }
                        }
                        message.Content = message.Attachments[0].FileName;
                        message.Path = $"Resource/Attachment/{DateTime.Now.Year}/{message.Attachments[0].FileName}";
                    }
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }

            Message msg = new Message()
            {
                Content = message.Content,
                Created = dateNow,
                CreatedBy = userCode,
                GroupCode = grp.Code,
                Path = message.Path,
                Type = message.Type,
            };

            grp.LastActive = dateNow;
            var updateUnread = grp.GroupUsers.Where(x => x.UserCode != userCode).ToList();
            foreach (GroupUser gr in updateUnread)
            {
                gr.Unread = gr.Unread + 1;
            };

            this.context.Messages.Add(msg);
            this.context.SaveChanges();

            try
            {
                var success = new
                {
                    text = "sent",
                    groupCode = grp.Code,
                    lastMessage = msg.Id,
                };
                var usersInGroup = grp.GroupUsers.ToList();
                foreach (var us in usersInGroup)
                {
                    if (us.User.CurrentSession != null)
                    {
                        this.chatHub.Clients.All.SendAsync("messageHubListener", success);
                    }
                }
                this.SeenMessage(msg.Id, userCode, groupCode);
            }
            catch (Exception ex) { }
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
            var usersInGroup = this.context.GroupUsers.Where(x => x.GroupCode == groupCode).ToList();
            foreach (var us in usersInGroup)
            {
                if (us.User.CurrentSession != null)
                {
                    this.chatHub.Clients.Client(us.User.CurrentSession).SendAsync("MessageSeen", dataReturn);
                }
            }

        }

        /// <summary>
        /// Lấy danh sách tin nhắn của mình từ nhóm
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="groupCode">Mã nhóm</param>
        /// <returns>Danh sách tin nhắn</returns>
        public List<MessageDto> GetMessageByGroup(string userCode, string groupCode)
        {
            var messages = this.context.Messages
                   .Where(x => x.GroupCode.Equals(groupCode))
                   .Where(x => x.Group.GroupUsers.Any(y => y.UserCode.Equals(userCode)))
                   .OrderBy(x => x.Created)
                   .Select(x => new MessageDto()
                   {
                       Created = x.Created,
                       Content = x.Content,
                       CreatedBy = x.CreatedBy,
                       GroupCode = x.GroupCode,
                       Id = x.Id,
                       Path = x.Path,
                       Type = x.Type,
                       isRemoved = x.isRemoved,
                       UserCreatedBy = new UserDto()
                       {
                           FullName = x.UserCreatedBy.FullName,
                           Avatar = x.UserCreatedBy.Avatar
                       }
                   }).ToList();
            try
            {
                var updateUnreadUser = this.context.GroupUsers.Where(x => x.GroupCode == groupCode && x.UserCode == userCode).FirstOrDefault();
                if (updateUnreadUser != null)
                {
                    updateUnreadUser.Unread = 0;
                    this.context.SaveChanges();
                }
                return messages;

            }
            catch (Exception ex)
            {
                return null;
            }
            /*    var lastMessage = this.context.Messages
                         .Where(x => x.Id.Equals(messages.LastOrDefault().Id)).Select(x => new MessageDto()
                         {
                             Created = x.Created,
                             Content = x.Content,
                             CreatedBy = x.CreatedBy,
                             GroupCode = x.GroupCode,
                             Id = x.Id,
                             Path = x.Path,
                             Type = x.Type,
                             UserCreatedBy = new UserDto()
                             {
                                 FullName = x.UserCreatedBy.FullName,
                                 Avatar = x.UserCreatedBy.Avatar
                             }
                         }).FirstOrDefault();
                var seenList = this.context.Messages.Where(x => x.Id == lastMessage.Id).Select(x => new { Code = x.SeenBy }).ToList();
                List<UserDto> seenListUserInfomartion = new List<UserDto>();
                foreach(var u in seenList)
                {
                    var user = this.context.Users.Where(x => x.Code == u.Code).Select(x => new UserDto
                    {
                        Avatar = x.Avatar,
                        FullName = x.FullName,
                        Code = x.Code,
                    }).FirstOrDefault();
                    seenListUserInfomartion.Add(user);
                }
                messages.FirstOrDefault(x => x.Id == lastMessage.Id).SeenList = seenListUserInfomartion;*/
        }

        /// <summary>
        /// Lấy danh sách tin nhắn của mình với người đã liên hệ
        /// </summary>
        /// <param name="userCode">User hiện tại đang đăng nhập</param>
        /// <param name="contactCode">Người nhắn cùng</param>
        /// <returns></returns>
        public List<MessageDto> GetMessageByContact(string userCode, string contactCode)
        {
            // Lấy mã nhóm đã từng nhắn tin giữa 2 người
            string groupCode = this.context.Groups
                    .Where(x => x.Type.Equals(Constants.GroupType.SINGLE))
                    .Where(x => x.GroupUsers.Any(y => y.UserCode.Equals(userCode) &&
                                x.GroupUsers.Any(y => y.UserCode.Equals(contactCode))))
                    .Select(x => x.Code)
                    .FirstOrDefault();

            return this.context.Messages
                    .Where(x => x.GroupCode.Equals(groupCode))
                    .Where(x => x.Group.GroupUsers.Any(y => y.UserCode.Equals(userCode)))
                    .OrderBy(x => x.Created)
                    .Select(x => new MessageDto()
                    {
                        Created = x.Created,
                        Content = x.Content,
                        CreatedBy = x.CreatedBy,
                        GroupCode = x.GroupCode,
                        Id = x.Id,
                        Path = x.Path,
                        Type = x.Type,
                        isRemoved = x.isRemoved,
                        UserCreatedBy = new UserDto()
                        {
                            Avatar = x.UserCreatedBy.Avatar
                        }
                    }).ToList();
        }
    }
}
