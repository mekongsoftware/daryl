using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Models
{
    public class Product
    {
        public int ProductId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public string Desciption { get; set; }
        public string VDescription { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<int> Category { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public string PicturePath { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}