using System;
using System.Linq;
using System.Net;
using System.Web.Http;
using System.Web.Http.Description;
using CRS.Core.DTO;
using CRS.Core.BusinessLogic;
using CRS.Core;
using System.Collections.Generic;

namespace CRS.Controllers
{
    public class OrdersController : ApiBaseController
    {
        [Route("api/Orders/GetRestaurant")]
        [ResponseType(typeof(RestaurantDto))]
        public IHttpActionResult GetRestaurant()
        {
            var restaurant = _businessLogic.GetRestaurant(Session.RestaurantId, "en");
            return Ok(restaurant);
        }

        //private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();
        private OrderBl _businessLogic = new OrderBl();

        [Route("api/Orders/GetOpenOrders/{tableId}")]
        [ResponseType(typeof(OrderDto))]
        public IHttpActionResult GetOpenOrders(Guid? tableId = null)
        {
            var url = Request.RequestUri;
            var isCompleted = false;

            var orders = _businessLogic.GetAllOrders(Session.RestaurantId, Session.CurrentLanguage, isCompleted, tableId).ToList();
            if (orders == null)
            {
                return NotFound();
            }
            return Ok(orders);
        }

        [Route("api/Orders/GetOrder/{orderId}")]
        [ResponseType(typeof(OrderDto))]
        public IHttpActionResult GetOrder(Guid orderId)
        {
            var url = Request.RequestUri;

            var order = _businessLogic.GetOneOrder(orderId, Session.CurrentLanguage);
            if (order == null)
            {
                return NotFound();
            }
            return Ok(order);
        }

        // PUT: api/Orders/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutOrder(Guid id, OrderDto order)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.SaveOrder(order);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Orders
        /// <summary>
        /// Save new order
        /// </summary>
        /// <param name="order"></param>
        /// <returns></returns>
        [ResponseType(typeof(OrderDto))]
        public IHttpActionResult PostOrder(OrderDto order)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.SaveOrder(order);
            return CreatedAtRoute("DefaultApi", new { id = order.OrderId }, order);
        }

        [Route("api/Orders/DeleteRestaurantOrders")]
        [ResponseType(typeof(OrderDto))]
        public IHttpActionResult DeleteOrder()
        {
            _businessLogic.DeleteRestaurantOrders(Session.RestaurantId);
            return StatusCode(HttpStatusCode.OK);
        }

        // DELETE: api/Orders/5
        //[HttpDelete]
        [Route("api/Orders/DeleteOrder/{orderId}")]
        [ResponseType(typeof(OrderDto))]
        public IHttpActionResult DeleteOrder(Guid orderId)
        {
            var ok = _businessLogic.DeleteOrder(orderId);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }
            return StatusCode(HttpStatusCode.OK);
        }

        [Route("api/Orders/UpdateOrderProductAddonStatus/{orderProductAddonId}/{statusId}")]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateOrderProductAddonStatus(Guid orderProductAddonId, int statusId)
        {
            //`var ok = _businessLogic.UpdateStatus(orderProductAddon, statusId);
            var ok = _businessLogic.UpdateOrderProductAddonStatus(orderProductAddonId, statusId);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }
            return StatusCode(HttpStatusCode.OK);
        }

        [Route("api/Orders/UpdateOrderProductStatus/{orderProductId}/{statusId}")]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateOrderProductStatus(Guid orderProductId, int statusId)
        {
            var ok = _businessLogic.UpdateOrderProductStatus(orderProductId, statusId);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }
            return StatusCode(HttpStatusCode.OK);
        }


        [Route("api/Orders/UpdateOrderProductStatuses/{statusId}")]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateOrderProductStatuses([FromUri] int statusId, [FromBody] List<OrderProductDto> orderProducts)
        {
            var ok = _businessLogic.UpdateOrderProductStatus(orderProducts, statusId);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }

            return StatusCode(HttpStatusCode.OK);
        }

        [Route("api/Orders/UpdateOrderStatus/{orderId}/{statusId}")]
        [ResponseType(typeof(void))]
        public IHttpActionResult UpdateOrderStatus(Guid orderId, int statusId)
        {
            var ok = _businessLogic.UpdateOrderStatus(orderId, statusId);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }
            return StatusCode(HttpStatusCode.OK);
        }

        [Route("api/Orders/CloseOrder/")]
        [ResponseType(typeof(void))]
        [HttpPost]
        public IHttpActionResult CloseOrder(OrderDto order)
        {
            var ok = _businessLogic.CloseOrder(order);
            if (!ok)
            {
                return StatusCode(HttpStatusCode.NotModified);
            }
            return StatusCode(HttpStatusCode.OK);
        }
    }
}