using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core
{
    public class Status
    {
        public enum Types { Table, Order, Item };

        // corresponding to Status table
        public const int TableAvailableStatusId = 110;
        public const int TableOccupiedStatusId = 120;

        public const int OrderPreOrderStatusId = 210;
        public const int OrderOrderConfirmedStatusId = 220;
        public const int OrderProcessingStatusId = 230;
        public const int OrderProcessedStatusId = 240;
        public const int OrderDeliveredStatusId = 250;
        public const int OrderCheckRequestedStatusId = 253;
        public const int OrderCheckedOutStatusId = 256;
        public const int OrderCancellRequestedStatusId = 260;
        public const int OrderCancelledStatusId = 270;
        public const int OrderPaidStatusId = 280;

        public const int ItemPreOrderStatusId = 410;
        public const int ItemOrderConfirmedStatusId = 420;
        public const int ItemProcessingStatusId = 430;
        public const int ItemProcessedStatusId = 440;
        public const int ItemDeliveredStatusId = 450;
        public const int ItemCancelRequestedStatusId = 460;
        public const int ItemCancelledStatusId = 470;
        public const int ItemDisposedStatusId = 490;

        // Order with these statuses is complete
        public static List<int?> OrderCompleteStatusIds = new List<int?> {
            OrderPaidStatusId,
            OrderCancelledStatusId
        };

        // Order with statuses will not shown in kitchen view
        public static List<int?> OrderKitchenCompleteStatusIds = new List<int?> {
            OrderPreOrderStatusId,
            //OrderPaidStatusId,
            OrderCancelledStatusId,
            OrderDeliveredStatusId
        };

        // List of statuses that indicate order is open (negate of OrderCompleteStatusIds?)
        public static List<int?> OrderOpenStatusIds = new List<int?> {
           OrderPreOrderStatusId,
           OrderOrderConfirmedStatusId,
           OrderProcessingStatusId,
           OrderProcessedStatusId,
           OrderDeliveredStatusId,
           OrderCheckRequestedStatusId,
           OrderCancelledStatusId,
           OrderPaidStatusId
        };

        // List of statuses that indicate item is complete
        public static List<int?> ItemCompleteStatusIds = new List<int?> {
            ItemDeliveredStatusId,
            ItemCancelledStatusId
            //ItemDisposedStatusId
        };

        // List of statuses that indicate item is open
        public static List<int?> ItemOpenStatusIds = new List<int?> {
            ItemOrderConfirmedStatusId,
            ItemProcessingStatusId,
            ItemProcessedStatusId,
            ItemCancelRequestedStatusId
        };
    }
}