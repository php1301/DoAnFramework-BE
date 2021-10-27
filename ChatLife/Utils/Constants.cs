﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ChatLife.Utils { 
    public class Constants
    {
        public class GroupType
        {
            public const string SINGLE = "single";
            public const string MULTI = "multi";
        }

        public class CallStatus
        {
            public const string IN_COMMING = "IN_COMMING";
            public const string OUT_GOING = "OUT_GOING";
            public const string MISSED = "MISSED";
        }

        public const string AVATAR_DEFAULT = "Resource/no_img.jpg";
    }
}
