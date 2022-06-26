using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class LookupAddonDto
    {
        public Guid AddonId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
        public bool? IsPriceChangeable { get; set; }
        public Nullable<Guid> CategoryId { get; set; }
    }
}