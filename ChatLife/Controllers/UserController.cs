using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
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
    public class UserController : ControllerBase
    {
        private UserService _usersService;
        private readonly IHttpContextAccessor _contextAccessor;

        public UserController(UserService usersService, IHttpContextAccessor contextAccessor)
        {
            this._usersService = usersService;
            this._contextAccessor = contextAccessor;
        }
        [Route("profile")]
        [HttpGet]
        public IActionResult GetProfile()
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._usersService.GetProfile(userSession);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("profile")]
        [HttpPut]
        public IActionResult UpdateProfile(UserDto user)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._usersService.UpdateProfile(userSession, user);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("contacts")]
        [HttpGet]
        public IActionResult GetContact()
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._usersService.GetContact(userSession);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("contacts/search")]
        [HttpGet]
        public IActionResult SearchContact(string keySearch = null)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                responseAPI.Data = this._usersService.SearchContact(userSession, keySearch);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("contacts")]
        [HttpPost]
        public IActionResult AddContact(UserDto user)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                this._usersService.AddContact(userSession, user);
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
