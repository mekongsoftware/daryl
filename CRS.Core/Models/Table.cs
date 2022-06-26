using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class Table
    {
        public Guid TableId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Name { get; set; }
        public string VName { get; set; }
        public string Description { get; set; }
        public string VDescription { get; set; }
        public string Shape { get; set; }
        public string Size { get; set; }
        public Nullable<int> Seats { get; set; }
        public Nullable<int> LocationX { get; set; }
        public Nullable<int> LocationY { get; set; }
        public Nullable<bool> IsForCustomer { get; set; }
        public Nullable<bool> IsActive { get; set; }
    }
}