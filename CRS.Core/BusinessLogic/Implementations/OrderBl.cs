using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using CRS.Core.DTO;
using CRS.Core.Helpers;

namespace CRS.Core.BusinessLogic
{
    public class OrderBl : IOrderBl
    {
        private ModelsEF.RestaurantEntities _db = new ModelsEF.RestaurantEntities();

        public RestaurantDto GetRestaurant(int resaurantId, string language)
        {
            var efRestaurant = _db.Restaurants.First(x => x.RestaurantId == resaurantId);
            return XMapper<RestaurantDto>.Map(efRestaurant, language);
        }

        /// <summary>
        /// Returns all lookup tables used in the system: categories, products, addons, users, tables
        /// </summary>
        /// <param name="restaurantId"></param>
        /// <param name="language"></param>
        /// <returns></returns>
        public LookupDto GetLookup(int restaurantId, string language)
        {
            var categories = _db.Categories.
                Where(x => x.RestaurantId == restaurantId
                    && (!x.IsActive.HasValue || x.IsActive.Value))
                .OrderBy(x => x.Sequence);
            var products = _db.Products
                .Where(x => x.RestaurantId == restaurantId
                && (!x.IsActive.HasValue || x.IsActive.Value)
                && x.PriceId == null)                           // PricdId with null is default product price (todo: for food truck...)
                .OrderBy(x => x.Sequence).ThenBy(x => x.Code);
            var addons = _db.Addons
                .Where(x => x.RestaurantId == restaurantId
                    && (!x.IsActive.HasValue || x.IsActive.Value))
                .OrderBy(x => x.Code);
            var users = _db.Users
                .Where(x => x.RestaurantId == restaurantId
                && (!x.IsActive.HasValue || x.IsActive.Value))
                .OrderBy(x => x.NameEn).ToList();
            var statuses = _db.Status
                .Where(x => (!x.IsActive.HasValue || x.IsActive.Value))        // null or true
                .OrderBy(x => x.Sequence).ToList();


            var lookup = new LookupDto();
            lookup.Categories = XMapper<LookupCategoryDto>.Map(categories, language);
            lookup.Products = XMapper<LookupProductDto>.Map(products, language);
            lookup.Addons = XMapper<LookupAddonDto>.Map(addons, language);
            lookup.Tables = GetLookupTables(restaurantId, language);
            lookup.Users = XMapper<LookupUserDto>.Map(users, "en");
            // use English for now
            //lookup.Statuses = XMapper<StatusDto>.Map(statuses, language);
            lookup.Statuses = XMapper<StatusDto>.Map(statuses, language);
            return lookup;
        }

        /// <summary>
        /// Returns table/order summary
        /// </summary>
        /// <param name="restaurantId"></param>
        /// <param name="language"></param>
        /// <returns></returns>
        public IEnumerable<LookupTableDto> GetTableOverview(int restaurantId, string language)
        {
            return GetLookupTables(restaurantId, language);
        }

        /// <summary>
        /// Returns all orders, optional by table (todo: add status, open or all order to parameters)
        /// </summary>
        /// <param name="restaurantId"></param>
        /// <param name="language"></param>
        /// <param name="tableId"></param>
        /// <returns></returns>
        public IEnumerable<OrderDto> GetAllOrders(int restaurantId, string language, bool? isCompleted, Guid? tableId)
        {
            var query = _db.Orders.Where(x => x.RestaurantId == restaurantId);
            if (tableId != null)
            {
                query = query.Where(x => x.TableId == tableId);
            }
            if (isCompleted == false)
            {
                query = query.Where(x => x.IsCompleted == null || x.IsCompleted == isCompleted);
            }
            else
            {
                query = query.Where(x => x.IsCompleted.Value == true);
            }

            query.OrderBy(x => x.TableId);       // not work! need to fix

            var orders = new List<OrderDto>();
            foreach (var order in query.ToList())
            {
                var detailedOrder = GetOneOrder(order.OrderId, language);
                orders.Add(detailedOrder);
            }
            return orders;
        }

        /// <summary>
        /// return one order
        /// </summary>
        /// <param name="id"></param>
        /// <param name="language"></param>
        /// <returns></returns>
        public OrderDto GetOneOrder(Guid id, string language)
        {
            var efOrder = _db.Orders.Find(id);
            if (efOrder == null)
            {
                return null;
            }
            var order = MapOrder(efOrder, language);
            return order;
        }

        /// <summary>
        /// Update status for addon 
        /// </summary>
        /// <param name="addon"></param>
        /// <param name="statusId"></param>
        /// <returns></returns>
        public bool UpdateOrderProductAddonStatus(Guid orderProductAddonId, int? statusId)
        {
            var orderProductAddon = _db.OrderProductAddons.Find(orderProductAddonId);
            orderProductAddon.StatusId = statusId;
            switch (statusId)
            {
                case Status.ItemProcessedStatusId:
                    orderProductAddon.FinishTime = Helper.TimeStamp();
                    break;
                case Status.ItemDeliveredStatusId:
                    orderProductAddon.DeliverTime = Helper.TimeStamp();
                    break;
            }

            // save OrderEvent
            var orderId = _db.OrderProducts.First(x => x.OrderProductId == orderProductAddon.OrderProductId).OrderId;
            AddOrderEvent(orderId, string.Format("OrderProductAddon {0} update status to {1}", orderProductAddon.AddonId, statusId));
            _db.SaveChanges();
            return true;
        }

        /// <summary>
        /// Updates status for product list
        /// </summary>
        /// <param name="orderProducts"></param>
        /// <param name="statusId"></param>
        /// <returns></returns>
        public bool UpdateOrderProductStatus(List<OrderProductDto> orderProducts, int? orderStatusId)
        {
            var itemStatusId = MapOrderToItemStatus(orderStatusId);
            foreach (var orderProduct in orderProducts)
            {
                if (Helper.NullOrTrue(orderProduct.IsInSelectedCategories))
                {
                    UpdateOrderProductStatus(orderProduct.OrderProductId, itemStatusId);
                }
            }
            return true;

        }
        /// <summary>
        /// Updates status for product 
        /// </summary>
        /// <param name="product"></param>
        /// <param name="statusId"></param>
        /// <returns></returns>
        public bool UpdateOrderProductStatus(Guid? orderProductId, int? statusId)
        {
            // update the product status
            var orderProduct = _db.OrderProducts.Find(orderProductId);
            orderProduct.StatusId = statusId;
            switch (statusId)
            {
                case Status.ItemProcessedStatusId:
                    orderProduct.FinishTime = Helper.TimeStamp();
                    break;
                case Status.ItemDeliveredStatusId:
                    orderProduct.DeliverTime = Helper.TimeStamp();
                    break;
                //case Status.ItemCancelledStatusId:
                //    // request cancel, make sure it's not already in process
                //    var currentStatus = _db.OrderProducts.Find(orderProduct.OrderProductId).StatusId;
                //    if (currentStatus != Status.ItemOrderConfirmedStatusId)
                //    {
                //        return false;
                //    }
                //    break;
            }
            // save OrderEvent
            AddOrderEvent(orderProduct.OrderId, string.Format("OrderProduct {0} update status to {1}", orderProduct.OrderId, statusId));
            _db.SaveChanges();

            // update addon for this product as well
            foreach (var orderProductAddon in orderProduct.OrderProductAddons)
            {
                UpdateOrderProductAddonStatus(orderProductAddon.OrderProductAddonId, statusId);
            }

            // updating parent, Order
            var order = _db.Orders.Find(orderProduct.OrderId);

            //// if item is Processing, set Order status to Processing
            //if (statusId == Status.ItemProcessingStatusId)
            //{
            //    order.StatusId = Status.OrderProcessingStatusId;
            //    _db.SaveChanges();
            //}

            // if item is complete, check all other products, if all complete then set parent Order status to Delivered
            if (Status.ItemCompleteStatusIds.Contains(statusId))
            {
                var openItemCount = 0;
                foreach (var p in order.OrderProducts)
                {
                    if (Status.ItemOpenStatusIds.Contains(p.StatusId))
                    {
                        openItemCount++;
                    }
                }
                if (openItemCount == 0)
                {
                    if (order.StatusId != Status.OrderPaidStatusId)
                    {
                        order.StatusId = Status.OrderDeliveredStatusId;
                    }
                    else
                    {
                        // if item is paid, set it to complete
                        if (ItemsCompleted(orderProduct.OrderId))
                        {
                            order.IsCompleted = true;
                        }
                    }
                }
                
                _db.SaveChanges();
                AddOrderEvent(orderProduct.OrderId, string.Format("Order {0} auto update status to {1}", orderProduct.OrderId, Status.OrderDeliveredStatusId));
            }
            
            return true;
        }


        /// <summary>
        /// Update status for order, and its product and addon
        /// </summary>
        /// <param name="order"></param>
        /// <param name="statusId"></param>
        /// <returns></returns>
        public bool UpdateOrderStatus(Guid orderId, int? statusId)
        {
            var order = _db.Orders.Find(orderId);
            order.StatusId = statusId;
            var itemStatusId = 0;
            switch (statusId)
            {
                case Status.OrderPaidStatusId:
                    order.PaidTime = Helper.TimeStamp();
                    break;
                case Status.OrderDeliveredStatusId:
                    order.DeliverTime = Helper.TimeStamp();
                    itemStatusId = Status.ItemDeliveredStatusId;
                    break;
                case Status.OrderCheckRequestedStatusId:
                    order.IsLocked = true;
                    break;

                case Status.OrderProcessingStatusId:
                    itemStatusId = Status.ItemProcessingStatusId;
                    break;
                case Status.OrderProcessedStatusId:
                    itemStatusId = Status.ItemProcessedStatusId;
                    break;
            }

            // update children
            if (itemStatusId != 0)
            {
                foreach (var orderProduct in order.OrderProducts)
                {
                    UpdateOrderProductStatus(orderProduct.OrderProductId, itemStatusId);
                }
            }

            order.StatusId = statusId;
            _db.Entry(order).State = EntityState.Modified;
            _db.SaveChanges();
            AddOrderEvent(order.OrderId, string.Format("Order {0} update status to {1}", order.OrderId, statusId));
            return true;
        }

        public bool CloseOrder(OrderDto order)
        {
            var efOrder = XMapper<ModelsEF.Order>.Map(order);
            var row = _db.Orders.Find(order.OrderId);
            switch (order.StatusId)
            {
                // if paid and all items are complete, set IsCompleted to true
                case Status.OrderPaidStatusId:
                    efOrder.PaidTime = Helper.TimeStamp();
                    if (ItemsCompleted(order.OrderId))
                    {
                        efOrder.IsCompleted = true;
                    }
                    break;
                // if cancelled, set IsCompleted to true
                case Status.OrderCancelledStatusId:
                    efOrder.IsCompleted = true;
                    break;
            }

            _db.Entry(row).CurrentValues.SetValues(efOrder);
            _db.SaveChanges();
            AddOrderEvent(order.OrderId, string.Format("Order {0} is closed with status ID {1}", order.OrderId, order.StatusId));
            return true;
        }

        /// <summary>
        /// Map a single order from Entity into DTO
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        private OrderDto MapOrder(ModelsEF.Order order, string language)
        {
            var orderDto = XMapper<OrderDto>.Map(order, language);
            orderDto.NextStatusId = NextStatusId(Status.Types.Order, orderDto.StatusId);
            orderDto.IsShownInKitchen = !Status.OrderKitchenCompleteStatusIds.Any(x => x == order.StatusId);
            var orderProducts = new List<OrderProductDto>();
            foreach (var p in order.OrderProducts)
            {
                var oderProduct = XMapper<OrderProductDto>.Map(p, language);
                oderProduct.NextStatusId = NextStatusId(Status.Types.Item, oderProduct.StatusId);
                oderProduct.OrderProductAddons = XMapper<OrderProductAddonDto>.Map(p.OrderProductAddons, language).ToList();
                foreach (var addon in oderProduct.OrderProductAddons)
                {
                    addon.NextStatusId = NextStatusId(Status.Types.Item, addon.StatusId);
                }
                orderProducts.Add(oderProduct);
            }
            orderDto.OrderProducts = orderProducts;
            return orderDto;
        }

        /// <summary>
        /// Add (orderId = null) or update Order
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        public bool SaveOrder(OrderDto order)
        {
            GetOrderTimeStamps(order);
            SaveOrderHeader(order);
            SaveOrderProducts(order);
            return true;
        }

        /// <summary>
        /// Assigns order timestamps to based on StatusId
        /// </summary>
        /// <param name="order"></param>
        private void GetOrderTimeStamps(OrderDto order)
        {
            if (order.CreatedTime == null)
            {
                order.CreatedTime = Helper.TimeStamp();
            }
            switch (order.StatusId)
            {
                case Status.OrderOrderConfirmedStatusId:
                    // maybe there are multiple confirms, keep the original one
                    if (order.OrderTime == null)
                    {
                        order.OrderTime = Helper.TimeStamp();
                    }
                    break;
                case Status.OrderPaidStatusId:
                    order.PaidTime = Helper.TimeStamp();
                    break;
                case Status.OrderDeliveredStatusId:
                    order.DeliverTime = Helper.TimeStamp();
                    break;
            }
        }


        /// <summary>
        /// Save order header to Order and OrderEvent tables
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        private Guid? SaveOrderHeader(OrderDto order)
        {
            var orderId = order.OrderId;
            var orderEvent = string.Empty;
            // update existing order
            if (order.OrderId != null)
            {
                orderEvent = "Order updated.";
                var efOrder = _db.Orders.Find(order.OrderId);
                var oldStatusId = _db.Orders.Find(order.OrderId).StatusId;
                XMapper<ModelsEF.Order>.Map(order, efOrder);

                // preserved old status in case order is submit again
                if (order.StatusId == Status.OrderOrderConfirmedStatusId)
                {
                    if (oldStatusId != Status.OrderPreOrderStatusId)
                    {
                        efOrder.StatusId = oldStatusId;
                    }
                }
                _db.Orders.Attach(efOrder);
                _db.Entry(efOrder).State = EntityState.Modified;
                _db.SaveChanges();
                AddOrderEvent(efOrder.OrderId, orderEvent);
            }
            // create new order
            else
            {
                var efOrder = XMapper<ModelsEF.Order>.Map(order);
                efOrder.OrderId = Guid.NewGuid();
                efOrder.CreatedTime = Helper.TimeStamp();
                order.OrderId = efOrder.OrderId;            // save for next operations
                _db.Orders.Add(efOrder);
                orderId = efOrder.OrderId;
                orderEvent = "Order created.";
                _db.SaveChanges();
                AddOrderEvent(efOrder.OrderId, orderEvent);
            }
            
            return orderId;
        }
        
        /// <summary>
        /// Maps order status to product status and assign time stamps
        /// </summary>
        /// <param name="orderStatusId"></param>
        /// <param name="efOrderProduct"></param>
        private void GetOrderProductStatusAndTimeStamps(int? orderStatusId, ModelsEF.OrderProduct efOrderProduct)
        {
            switch (orderStatusId)
            {
                case Status.OrderPreOrderStatusId:
                    efOrderProduct.StatusId = Status.ItemPreOrderStatusId;
                    break;
                case Status.OrderOrderConfirmedStatusId:
                    // update new item only
                    if (efOrderProduct.StatusId==null || efOrderProduct.StatusId == Status.ItemPreOrderStatusId)
                    {
                        efOrderProduct.StatusId = Status.ItemOrderConfirmedStatusId;
                        if (efOrderProduct.OrderTime == null)
                        {
                            efOrderProduct.OrderTime = Helper.TimeStamp();
                        }
                    }
                    break;
                case Status.OrderProcessingStatusId:
                    efOrderProduct.StatusId = Status.ItemProcessingStatusId;
                    break;
                case Status.OrderProcessedStatusId:
                    efOrderProduct.StatusId = Status.ItemProcessedStatusId;
                    if (efOrderProduct.FinishTime == null)
                    {
                        efOrderProduct.FinishTime = Helper.TimeStamp();
                    }
                    break;
                case Status.OrderDeliveredStatusId:
                    efOrderProduct.StatusId = Status.OrderDeliveredStatusId;
                    if (efOrderProduct.DeliverTime == null)
                    {
                        efOrderProduct.DeliverTime = Helper.TimeStamp();
                    }
                    break;
                // case Status.OrderCheckRequestedStatusId: do nothing
                // case Status.OrderCheckedOutStatusId: do nothing
                case Status.OrderCancelledStatusId:
                    efOrderProduct.StatusId = Status.ItemCancelledStatusId;
                    break;
                
            }
        }
        /// <summary>
        /// Add/Update OrderProduct, OrderProductAddon
        /// </summary>
        /// <param name="order"></param>
        private void SaveOrderProducts(OrderDto order)
        {
            // delete existing entries in OrderProductAddon and OrderProduct
            DeleteOrderProducts(order);

            // add to OrderProduct
            foreach (var p in order.OrderProducts)
            {
                var efOrderProduct = XMapper<ModelsEF.OrderProduct>.Map(p);
                efOrderProduct.OrderProductId = Guid.NewGuid();
                efOrderProduct.OrderId = order.OrderId;
                GetOrderProductStatusAndTimeStamps(order.StatusId, efOrderProduct);
                _db.OrderProducts.Add(efOrderProduct);
                _db.SaveChanges();
                var orderProductId = efOrderProduct.OrderProductId;
                // add to OrderProductAddon
                foreach (var a in p.OrderProductAddons)
                {
                    var efProductAddon = XMapper<ModelsEF.OrderProductAddon>.Map(a);
                    efProductAddon.OrderProductId = orderProductId;
                    efProductAddon.OrderProductAddonId = Guid.NewGuid();

                    // needs another map status & time stamp here...
                    if (order.StatusId == Status.OrderOrderConfirmedStatusId
                        && efProductAddon.OrderTime == null)
                    {
                        efProductAddon.OrderTime = Helper.TimeStamp();
                        efProductAddon.StatusId = Status.ItemOrderConfirmedStatusId;
                    }
                    _db.OrderProductAddons.Add(efProductAddon);
                    _db.SaveChanges();
                }
            }
        }

        /// <summary>
        /// Delete entries in OrderProduct and OrderProductAddon
        /// </summary>
        /// <param name="order"></param>
        private void DeleteOrderProducts(OrderDto order)
        {
            if (order.OrderProducts.Count == 0)
            {
                return;
            }
            // remove entries in OrderProductAddon
            var productIds = order.OrderProducts.Select(x => x.OrderProductId).ToList();
            var addons = _db.OrderProductAddons.Where(x => productIds.Contains(x.OrderProductId));
            _db.OrderProductAddons.RemoveRange(addons);
            _db.SaveChanges();

            // remove entries in OrderProduct    
            var products = _db.OrderProducts.Where(x => x.OrderId == order.OrderId);
            _db.OrderProducts.RemoveRange(products);
            _db.SaveChanges();
        }

        /// <summary>
        /// Add event to OrderEvent table
        /// </summary>
        /// <param name="orderId"></param>
        /// <param name="orderEvent"></param>
        private void AddOrderEvent(Guid? orderId, string orderEvent)
        {
            var efOrderEvent = new ModelsEF.OrderEvent
            {
                OrderEventId = Guid.NewGuid(),
                OrderId = orderId,
                DescriptionEn = orderEvent,
                TimeStamp = Helper.TimeStamp()

            };
            _db.OrderEvents.Add(efOrderEvent);
            _db.SaveChanges();
        }

        /// <summary>
        /// Delete existing order
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool DeleteOrder(Guid? id)
        {
            var order = _db.Orders.Find(id);
            if ((order == null)) // || efOrder.StatusId != Status.OrderPreOrderStatusId)     // only allow preorder to be deleted
            {
                return false;
            }
            foreach (var orderProduct in order.OrderProducts.ToList())
            {
                foreach (var orderProductAddon in orderProduct.OrderProductAddons)
                {
                    var addon = _db.OrderProductAddons.Find(orderProductAddon.OrderProductAddonId);
                    _db.Entry(addon).State = EntityState.Deleted;
                }
                _db.SaveChanges();
                var product = _db.OrderProducts.Find(orderProduct.OrderProductId);
                _db.Entry(product).State = EntityState.Deleted;
            }
            _db.SaveChanges();

            _db.OrderEvents.RemoveRange(
                _db.OrderEvents.Where(x => x.OrderId == id)
            );

            _db.Entry(order).State = EntityState.Deleted;
            _db.SaveChanges();
            return true;
        }

        public void DeleteRestaurantOrders(int restaurantId)
        {
            _db.Database.ExecuteSqlCommand("EXEC DeleteRestaurantOrders {0}", restaurantId);
        }

        private bool OrderExists(Guid id)
        {
            return _db.Orders.Count(e => e.OrderId == id) > 0;

        }

        /// <summary>
        /// returns list of tables, with pending orders
        /// </summary>
        /// <param name="restaurantId"></param>
        /// <param name="language"></param>
        /// <returns></returns>
        private IEnumerable<LookupTableDto> GetLookupTables(int restaurantId, string language)
        {
            var efTables = _db.Tables
                .Where(x => x.RestaurantId == restaurantId && x.IsActive.Value && x.IsForCustomer.Value)
                .OrderBy(x => x.NameEn).ToList();
            var tables = XMapper<LookupTableDto>.Map(efTables, language);
            foreach (var table in tables)
            {
                table.PendingOrders = GetPendingOrders(restaurantId, table.TableId);
            }
            return tables;
        }

        private IEnumerable<Guid> GetPendingOrders(int restaurantId, Guid tableId)
        {
            return _db.Orders.Where(
                x => x.RestaurantId == restaurantId && x.TableId == tableId
                && !Status.OrderCompleteStatusIds.Contains(x.StatusId.Value)
                ).Select(x => x.OrderId).ToList();
        }

        /// <summary>
        /// find nextStatusId, return 0 if order/item is complete
        /// </summary>
        /// <param name="statusType"></param>
        /// <param name="statusId"></param>
        /// <returns></returns>
        private int NextStatusId(Status.Types statusType, int? statusId)
        {

            // completed
            if ((statusType == Status.Types.Order && Status.OrderKitchenCompleteStatusIds.Any(x => x == statusId)) ||
                (statusType == Status.Types.Item) && (Status.ItemCompleteStatusIds.Any(x => x == statusId))
                )
            {
                return 0;
            }

            var statuses = _db.Status.Where(x => x.ApplyTo == statusType.ToString().ToUpper()).OrderBy(x => x.Sequence).ToList();
            var nextStatusIndex = statuses.FindIndex(x => x.StatusId == statusId) + 1;
            return nextStatusIndex < statuses.Count() ? statuses[nextStatusIndex].StatusId : 0;
        }

        /// <summary>
        /// check if all addons are complete for these products
        /// </summary>
        /// <param name="orderProductIds"></param>
        /// <returns></returns>
        private bool AddonsCompleted(List<Guid?> orderProductIds)
        {
             var addons = from p in orderProductIds
                         from a in _db.OrderProductAddons
                         where p == a.OrderProductId
                         select new { a.StatusId };
            return !addons.Any(x => Status.ItemOpenStatusIds.Contains(x.StatusId));
        }

        /// <summary>
        /// Check if all products are completed
        /// </summary>
        /// <param name="orderId"></param>
        /// <returns></returns>
        private bool ProductsCompleted(Guid? orderId)
        {
            var products = _db.OrderProducts
                .Where(x => x.OrderId == orderId).ToList();
            return !products.Any(x => Status.ItemOpenStatusIds.Contains(x.StatusId));
        }

        private bool ItemsCompleted(Guid? orderId)
        {
           if (!ProductsCompleted(orderId))
            {
                return false;
            }

            var products = _db.OrderProducts
                .Where(x => x.OrderId == orderId)
                .Select(x=> x.ProductId).ToList();
            if (!AddonsCompleted(products))
            {
                return false;
            }
            return true;
        }

        private int? MapOrderToItemStatus(int? orderStatusId)
        {
            var itemStatusId = Status.ItemPreOrderStatusId;

            switch (orderStatusId)
            {
                case Status.OrderProcessingStatusId:
                    itemStatusId = Status.ItemProcessingStatusId;
                    break;
                case Status.OrderProcessedStatusId:
                    itemStatusId = Status.ItemProcessedStatusId;
                    break;
                case Status.OrderDeliveredStatusId:
                    itemStatusId = Status.ItemDeliveredStatusId;
                    break;
            }
            return itemStatusId;
        }
    }
}