using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.DTO
{
    public class OrderDto
    {
        public int OrderId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<int> Table { get; set; }
        public Nullable<int> PartySize { get; set; }
        public Nullable<System.DateTime> OrderTime { get; set; }
        public Nullable<System.DateTime> DeliverTime { get; set; }
        public Nullable<System.DateTime> PaidTime { get; set; }
        public Nullable<decimal> OrderAmout { get; set; }
        public Nullable<decimal> TipAmount { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
        public Nullable<int> OrderStaff { get; set; }
        public Nullable<int> ServiceStaff { get; set; }
        public Nullable<int> CashierStaff { get; set; }
        public string Note { get; set; }
    }
}