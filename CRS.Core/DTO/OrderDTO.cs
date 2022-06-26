using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.DTO
{
    public class OrderDto 
    {
        public Guid? OrderId { get; set; }
        public string OrderNumber { get; set; }
        public Nullable<int> StatusId { get; set; }
        public int NextStatusId { get; set; }
        public bool? IsShownInKitchen { get; set; }
        public bool? IsLocked { get; set; }
        public bool? IsCompleted{ get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public Nullable<Guid> TableId { get; set; }
        public Nullable<Guid> OrderTypeId { get; set; }
        public Nullable<int> PartySize { get; set; }
        public Nullable<bool> SplitBillEvenFlag { get; set; }
        public Nullable<System.DateTime> OrderTime { get; set; }
        public Nullable<System.DateTime> DeliverTime { get; set; }
        public Nullable<System.DateTime> PaidTime { get; set; }
        public Nullable<decimal> OrderAmount { get; set; }
        public Nullable<decimal> TipAmount { get; set; }
        public Nullable<decimal> TotalAmount { get; set; }
        public Nullable<Guid> OrderStaffId { get; set; }
        public Nullable<Guid> ServiceStaffId { get; set; }
        public Nullable<Guid> CashierStaffId { get; set; }
        public Nullable<Guid> CreatedBy { get; set; }
        public Nullable<DateTime> CreatedTime { get; set; }
        public string Note { get; set; }

        public string CustomerName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public Nullable<bool> EmailReceiptFlag { get; set; }
        public Nullable<bool> TextReceiptFlag { get; set; }
        public Nullable<decimal> TaxRatePercent { get; set; }
        public Nullable<bool> IsToGo { get; set; }
        public List<OrderProductDto> OrderProducts { get; set; }
    }
}