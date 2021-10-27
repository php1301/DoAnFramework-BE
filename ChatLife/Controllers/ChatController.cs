﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ChatLife.Dto;
using ChatLife.Services;


namespace ChatLife.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatController : ControllerBase
    {
        private ChatService _chatBoardService;
        private readonly IHttpContextAccessor _contextAccessor;

        public ChatController(ChatService chatBoardService, IHttpContextAccessor contextAccessor)
        {
            this._chatBoardService = chatBoardService;
            this._contextAccessor = contextAccessor;
        }
        [Route("get-history")]
        [HttpGet]
        public IActionResult GetHistory()
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._chatBoardService.GetHistory(userSession);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("get-info")]
        [HttpGet]
        public IActionResult GetInfo(string groupCode, string contactCode)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._chatBoardService.GetInfo(userSession, groupCode, contactCode);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("groups")]
        [HttpPost]
        public IActionResult AddGroup(GroupDto group)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                this._chatBoardService.AddGroup(userSession, group);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("update-group-avatar")]
        [HttpPut]
        public IActionResult UpdateGroupAvatar(GroupDto group)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                responseAPI.Data = this._chatBoardService.UpdateGroupAvatar(group);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("send-message")]
        [HttpPost]
        public IActionResult SendMessage([FromQuery] string groupCode)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string jsonMessage = HttpContext.Request.Form["data"];
                var settings = new JsonSerializerSettings
                {
                    NullValueHandling = NullValueHandling.Ignore,
                    MissingMemberHandling = MissingMemberHandling.Ignore
                };
                MessageDto message = JsonConvert.DeserializeObject<MessageDto>(jsonMessage, settings);
                message.Attachments = Request.Form.Files.ToList();

                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                this._chatBoardService.SendMessage(userSession, groupCode, message);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("get-message-by-group/{groupCode}")]
        [HttpGet]
        public IActionResult GetMessageByGroup(string groupCode)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._chatBoardService.GetMessageByGroup(userSession, groupCode);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("get-message-by-contact/{contactCode}")]
        [HttpGet]
        public IActionResult GetMessageByContact(string contactCode)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._chatBoardService.GetMessageByContact(userSession, contactCode);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }
    }
}
