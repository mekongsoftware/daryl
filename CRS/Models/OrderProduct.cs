using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class OrderProduct
    {
        public int OrderProductId { get; set; }
        public int? ProductId { get; set; }
        public decimal? Price { get; set; }
        public string Note { get; set; }
        public List<OrderProductAddon> ProductAddons { get; set; }
    }
}