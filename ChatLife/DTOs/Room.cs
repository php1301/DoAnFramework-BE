using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ChatLife.Dto
{
    /// <summary>
    /// model room response từ API
    /// </summary>
    public class Room
    {
        public string id { get; set; }
        public string name { get; set; }
        public string api_created { get; set; }
        public string privacy { get; set; }
        public string url { get; set; }
        public DateTime created_at { get; set; }
    }
}
