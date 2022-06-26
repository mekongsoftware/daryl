using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using CRS.Models;
using CRS.BusinessLogic;
using CRS.Helpers;




namespace CRS.BusinessLogic
{
    public class OrderBL : IOrderBL
    {
        private Models_Ef.RestaurantEntities db = new Models_Ef.RestaurantEntities();

        public IQueryable<Order> GetAll(int restaurantId)
        {
            return db.Orders.Where(x => x.RestaurantId == restaurantId).Project().To<Order>();
            //return db.Orders.Where(x => x.RestaurantId == restaurantId).Select(x => new Order
            //{
            //    OrderId = x.OrderId,
            //    RestaurantId = x.RestaurantId,
            //    TableId = x.TableId,
            //    PartySize = x.PartySize,
            //    OrderTime = x.OrderTime,
            //    DeliverTime = x.DeliverTime,
            //    PaidTime = x.PaidTime,
            //    OrderAmout = x.OrderAmout,
            //    TipAmount = x.TipAmount,
            //    TotalAmount = x.TotalAmount,
            //    OrderStaff = x.OrderStaff,
            //    ServiceStaff = x.ServiceStaff,
            //    CashierStaff = x.CashierStaff,
            //    Note = x.Note
            //    //,OrderProducts = x.OrderProducts
            //});
        }

        public Order GetOne(int id)
        {
            var efOrder = db.Orders.Find(id);
            if (efOrder == null)
            {
                return null;
            }

            // get OrderProduct list
            var orderProducts = db.OrderProducts.Where(x => x.OrderId == id)
                .Select(x => new OrderProduct
                {
                    ProductId = x.ProductId,
                    OrderProductId = x.OrderProductId,
                    Price = x.Product.Price,
                    Note = x.Notes
                }).ToList();

            // populate Addon 
            foreach (var orderProduct in orderProducts)
            {
                var productAddons = from opa in db.OrderProductAddons
                                    join a in db.Addons on opa.AddonId equals a.AddonId
                                    where (opa.OrderProductId == orderProduct.OrderProductId)
                                    select new OrderProductAddon
                                    {
                                        OrderProductAddonId = opa.OrderProductAddonId,
                                        OrderProductId = opa.OrderProductId,
                                        AddonId = opa.AddonId,
                                        Price = a.Price
                                    };
                orderProduct.ProductAddons = productAddons.ToList();
            }

            var order = Mapper<Order>.Map(efOrder);
            order.OrderProducts = orderProducts;

            return order;

            //{
            //    OrderId = order.OrderId
            //   ,RestaurantId = order.RestaurantId
            //   ,TableId = order.TableId
            //   ,PartySize = order.PartySize
            //   ,OrderTime = order.OrderTime
            //   ,DeliverTime = order.DeliverTime
            //   ,PaidTime = order.PaidTime
            //   ,OrderAmout = order.OrderAmout
            //   ,TipAmount = order.TipAmount
            //   ,TotalAmount = order.TotalAmount
            //   ,OrderStaff = order.OrderStaff
            //   ,ServiceStaff = order.ServiceStaff
            //   ,CashierStaff = order.CashierStaff
            //   ,Note = order.Note
            //   //,OrderProducts = 
            //};
        }

        public bool Update(Order order)
        {
            Delete(order.OrderId);
            Add(order);

            return true;
        }

        public bool Add(Order order)
        {
            try
            {
                // create Order
                var efOrder = Mapper<Models_Ef.Order>.Map(order);
                db.Orders.Add(efOrder);
                db.SaveChanges();
                var orderId = order.OrderId;

                // add Product
                foreach (var p in order.OrderProducts)
                {
                    var efOrderProduct = Mapper<Models_Ef.OrderProduct>.Map(p);
                    db.OrderProducts.Add(efOrderProduct);
                    db.SaveChanges();
                    var orderProductId = efOrderProduct.OrderProductId;
                    // add Product Addon
                    foreach (var a in p.ProductAddons)
                    {
                        var efProductAddon = Mapper<Models_Ef.OrderProductAddon>.Map(a);
                        db.OrderProductAddons.Add(efProductAddon);
                        db.SaveChanges();
                    }
                }
            }
            catch
            {
                return false;
            }
            return true;
        }
        public bool Delete(int id)
        {
            var efOrder = db.Orders.Find(id);
            if (efOrder == null)
            {
                return false;
            }
            //try
            //{
            //    var orderProducts = db.OrderProducts.Where(p => p.OrderId == efOrder.OrderId);
            //    foreach (var orderProduct in orderProducts)
            //    {
            //        var efOrderProduct = db.OrderProducts.Find(orderProduct.OrderProductId);
            //        if (efOrderProduct != null)
            //        {
            //            var productAddons = db.ProductAddons.Where(a => a.OrderProductId == orderProduct.OrderProductId);
            //            foreach (var productAddon in productAddons)
            //            {
            //                // delete addon from product
            //                var efAddon = db.ProductAddons.Find(productAddon.ProductAddonId);
            //                if (efAddon != null)
            //                {
            //                    db.ProductAddons.Remove(efAddon);
            //                }
            //            }
            //            // then delete product from order
            //            db.OrderProducts.Remove(efOrderProduct);
            //        }
            //    }
            //    // then finally delete order
            //    db.Orders.Remove(efOrder);
            //    db.SaveChanges();
            //}
            //catch
            //{
            //    return false;
            //}
            return true;
        }

        private bool OrderExists(int id)
        {
            return db.Orders.Count(e => e.OrderId == id) > 0;

        }
    }
}