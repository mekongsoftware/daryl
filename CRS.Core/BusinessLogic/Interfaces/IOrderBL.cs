using CRS.Core.DTO;
using System;
using System.Collections.Generic;

namespace CRS.Core.BusinessLogic
{
    public interface IOrderBl
    {
        RestaurantDto GetRestaurant(int resaurantId, string language);
        LookupDto GetLookup(int restaurantId, string language);
        IEnumerable<OrderDto> GetAllOrders(int restaurantId, string language, bool? isCompleted, Guid? tableId);
        OrderDto GetOneOrder(Guid id, string language);
        bool SaveOrder(OrderDto Order);
        bool DeleteOrder(Guid? id);
        void DeleteRestaurantOrders(int restaurantId);
        bool UpdateOrderProductAddonStatus(Guid orderProductAddonId, int? statusId);
        bool UpdateOrderProductStatus(Guid? orderProductId, int? statusId);
        bool UpdateOrderProductStatus(List<OrderProductDto> orderProducts, int? statusId);
        bool UpdateOrderStatus(Guid orderId, int? statusId);
        bool CloseOrder(OrderDto order);
    }
}