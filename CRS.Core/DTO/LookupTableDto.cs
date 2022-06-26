using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class LookupTableDto
    {
        public Guid TableId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public IEnumerable<Guid> PendingOrders { get; set; }
        public StatusDto Status { get; set; }
        public int Seats { get; set; }

    }
}
