using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class OrderProductDto
    {
        public Guid? OrderProductId { get; set; }
        public Guid? OrderId { get; set; }
        public Guid? ProductId { get; set; }
        public int? StatusId { get; set; }
        public int? NextStatusId { get; set; }
        public int Sequence{ get; set; }
        public int Quantity{ get; set; }
        public int SeatNumber{ get; set; }
        public DateTime? OrderTime { get; set; }
        public DateTime? FinishTime { get; set; }
        public DateTime? DeliverTime { get; set; }
        public decimal? Price { get; set; }
        public bool? IsComplementary { get; set; }
        public bool? IsToGo{ get; set; }
        public bool? IsInSelectedCategories { get; set; }
        public string Notes { get; set; }
        public List<OrderProductAddonDto> OrderProductAddons { get; set; }
        

    }
}