using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class Session
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int RestaurantId { get; set; }
        public string RestaurantName { get; set; }
    }
}