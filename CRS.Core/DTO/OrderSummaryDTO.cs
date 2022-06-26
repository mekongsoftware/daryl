using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class OrderSummaryDto 
    {
        public Guid? OrderId { get; set; }
        public string OrderName { get; set; }
        public Nullable<int> OrderStatus { get; set; }
        public string OrderStatusText { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<Guid> TableId { get; set; }
        public Nullable<Guid> OrderTypeId { get; set; }
        
        public Nullable<int> PartySize { get; set; }
        public Nullable<System.DateTime> OrderTime { get; set; }
        public Nullable<System.DateTime> DeliverTime { get; set; }
        public Nullable<System.DateTime> PaidTime { get; set; }
        public Nullable<decimal> OrderAmout { get; set; }
        public Nullable<decimal> TipAmount { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
        public Nullable<Guid> OrderStaff { get; set; }
        public Nullable<Guid> ServiceStaff { get; set; }
        public Nullable<Guid> CashierStaff { get; set; }
        public string Note { get; set; }

        public IEnumerable<OrderProductDto> OrderProducts { get; set; }
    }
}