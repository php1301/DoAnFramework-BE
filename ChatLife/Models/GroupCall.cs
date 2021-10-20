﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ChatLife.Models
{
    [Table("GroupCall")]
    public class GroupCall
    {
        [Key]
        public string Code { get; set; }
        public string Type { get; set; }
        public string Avatar { get; set; }
        public string Name { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }
        public DateTime LastActive { get; set; }

        public virtual ICollection<Call> Calls { get; set; }
    }
}
