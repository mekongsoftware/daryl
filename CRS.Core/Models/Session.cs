using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class Session
    {
        public Guid UserId { get; set; }
        public string UserName { get; set; }
        public int RestaurantId { get; set; }
        public string RestaurantName { get; set; }
    }
}