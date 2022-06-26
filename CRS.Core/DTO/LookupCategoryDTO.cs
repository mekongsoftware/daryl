using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class LookupCategoryDto
    {
        public Guid CategoryId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
    }
}