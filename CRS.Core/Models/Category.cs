using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class Category
    {
        public Guid CategoryId { get; set; }
        public Nullable<int> RestaurantId { get; set; }

        public string Name { get; set; }
        //public string NameVi { get; set; }
        //public string NameKo { get; set; }
        //public string NameEs { get; set; }
        //public string NameZh { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}