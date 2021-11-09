using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace ChatLife.Models
{
    [Table("MessageSeen")]
    public class MessageSeen
    {
        [Key]
        public long Id { get; set; }
        public long MessageId { get; set; }
        public string UserCode { get; set; }
        public string GroupCode { get; set; }
        public DateTime Created { get; set; }

        public virtual Message Message { get; set; }
        public virtual User User { get; set; }
        public virtual Group Group { get; set; }
    }
}