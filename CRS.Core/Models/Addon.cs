using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class Addon
    {
        public Guid AddonId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<int> CategoryId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public string IsActive { get; set; }
    }
}