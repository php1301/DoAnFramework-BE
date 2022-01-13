using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ChatLife.Dto
{
    public class MessageDto
    {
        public long Id { get; set; }
        public string Type { get; set; }
        public string GroupCode { get; set; }
        public string Content { get; set; }
        public string Path { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public int isRemoved { get; set; }

        public string SendTo { get; set; }
        public UserDto UserCreatedBy { get; set; }
        public List<IFormFile> Attachments { get; set; }
        public List<UserDto> SeenList { get; set; }
    }
}
