using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class OrderProductAddon
    {
        public int OrderProductAddonId { get; set; }
        public int? OrderProductId { get; set; }
        public int? AddonId { get; set; }
        public decimal? Price { get; set; }
    }
}