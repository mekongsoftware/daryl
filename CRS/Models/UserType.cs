using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class UserType
    {
        public int UserTypeId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}