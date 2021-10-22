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

    }
}
