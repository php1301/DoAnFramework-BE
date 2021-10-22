﻿using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using ChatLife.Dto;
using ChatLife.Models;
using ChatLife.Utils;

namespace ChatLife.Services
{
    public class AuthService
    {
        protected readonly MyContext context;

        public AuthService(MyContext context)
        {
            this.context = context;
        }

        public AccessToken Login(User user)
        {
            string passCheck = DataHelper.SHA256Hash(user.UserName + "_" + user.Password);
            User userExist = context.Users.Where(x => x.UserName.Equals(user.UserName) && x.Password.Equals(passCheck)).FirstOrDefault();
            if(userExist == null)
            {
                throw new ArgumentException("Sai thông tin đăng nhập");
            }
            userExist.LastLogin = DateTime.Now;
            context.SaveChanges();

            DateTime expirationDate = DateTime.Now.Date.AddMinutes(EnviConfig.ExpirationInMinutes);
            long expiresAt = (long)(expirationDate - new DateTime(1970, 1, 1)).TotalSeconds;
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(EnviConfig.SecretKey);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
              {
                        new Claim(ClaimTypes.Sid, userExist.Code),
                        new Claim(ClaimTypes.Name, userExist.UserName),
                        new Claim(ClaimTypes.Expiration, expiresAt.ToString())
              }),
                Expires = expirationDate,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature),
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return new AccessToken
            {
                User = userExist.Code,
                FullName = userExist.FullName,
                Avatar = userExist.Avatar,
                Token = tokenHandler.WriteToken(token),
            };
        }
    }
}