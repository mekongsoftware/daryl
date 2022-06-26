using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.DTO
{
    public class SessionDto
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int RestaurantId { get; set; }
        public string RestaurantName { get; set; }
        public int AccessLevel { get; set; }
    }
}