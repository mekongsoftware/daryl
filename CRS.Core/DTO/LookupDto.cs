using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class LookupDto
    {
        public IEnumerable<LookupAddonDto> Addons {get; set;}
        public IEnumerable<LookupCategoryDto> Categories{ get; set; }
        public IEnumerable<LookupProductDto> Products{ get; set; }
        public IEnumerable<LookupTableDto> Tables{ get; set; }
        public IEnumerable<LookupUserDto> Users { get; set; }
        public IEnumerable<StatusDto> Statuses { get; set; }
    }
}