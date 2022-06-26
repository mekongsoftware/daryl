using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class OrderProductAddonDto
    {
        public Guid? OrderProductAddonId { get; set; }
        public Guid? OrderProductId { get; set; }
        public Guid? AddonId { get; set; }
        public DateTime? OrderTime { get; set; }
        public DateTime? FinishTime { get; set; }
        public DateTime? DeliverTime { get; set; }
        public decimal? Price { get; set; }
        public bool? IsComplementary{ get; set; }
        public bool? IsTogo { get; set; }
        public int? StatusId{ get; set; }
        public int? NextStatusId { get; set; }
    }
}