using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using ChatLife.Dto;
using ChatLife.Models;
using ChatLife.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace ChatLife.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private AuthService _authService;
        private IWebHostEnvironment _hostEnvironment;
        private readonly IHttpContextAccessor _contextAccessor;

        public AuthController(AuthService authService, IWebHostEnvironment hostEnvironment, IHttpContextAccessor contextAccessor)
        {
            this._authService = authService;
            this._hostEnvironment = hostEnvironment;
            this._contextAccessor = contextAccessor;
        }
        [Route("auths/login")]
        [HttpPost]
        public IActionResult Login(User user)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                AccessToken accessToken = this._authService.Login(user);
                responseAPI.Data = accessToken;
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }
          [Route("auths/sign-up")]
        [HttpPost]
        public IActionResult SignUp(User user)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                this._authService.SignUp(user);
                return Ok(responseAPI);
            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [HttpGet("img")]
        public IActionResult DownloadImage(string key)
        {
            try
            {
                string path = Path.Combine(this._hostEnvironment.ContentRootPath, key);
                var image = System.IO.File.OpenRead(path);
                return File(image, "image/*");
            }
            catch (Exception ex)
            {
                return BadRequest();
            }
        }

        [HttpGet("file")]
        public IActionResult DownloadFile(string key)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string pathTemplate = Path.Combine(this._hostEnvironment.ContentRootPath, key);
                Stream stream = new FileStream(pathTemplate, FileMode.Open);
                responseAPI.Data = "";
                return File(stream, "application/octet-stream", key);

            }
            catch (Exception ex)
            {
                responseAPI.Message = ex.Message;
                return BadRequest(responseAPI);
            }
        }

        [Route("post-hubconnection")]
        [HttpPost]
        public IActionResult PutHubConnection(string key)
        {
            ResponseAPI responseAPI = new ResponseAPI();
            try
            {
                string userSession = SystemAuthorizationService.GetCurrentUser(this._contextAccessor);
                this._authService.PutHubConnection(userSession, key);
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
