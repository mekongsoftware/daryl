using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class Addon
    {
        public int AddonId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<int> Category { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public string IsActive { get; set; }
    }
}