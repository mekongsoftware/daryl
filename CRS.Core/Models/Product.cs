using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class Product
    {
        public Guid ProductId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Code { get; set; }
        public string NameEn { get; set; }
        public string NameVi { get; set; }
        public string NameKo { get; set; }
        public string NameEs { get; set; }
        public string NameZh { get; set; }
        public string DescriptionEn { get; set; }
        public string DescriptionVi { get; set; }
        public string DescriptionKo { get; set; }
        public string DescriptionEs { get; set; }
        public string DescriptionZh { get; set; }
        public Nullable<decimal> Price { get; set; }
        public Nullable<Guid> CategoryId { get; set; }
        public Nullable<int> PrepareMinutes { get; set; }
        public string PicturePath { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}