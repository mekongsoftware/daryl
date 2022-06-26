using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using CRS.Models;
using CRS.BusinessLogic;

namespace CRS.Controllers
{
    public class OrdersController : ApiController
    {
        //private Models_Ef.RestaurantEntities db = new Models_Ef.RestaurantEntities();
        private OrderBL _businessLogic = new OrderBL();

        // GET: api/Orders/1
        public IQueryable<Order> GetOrders(int restaurantId)
        {
            return _businessLogic.GetAll(restaurantId);
        }

        // GET: api/Orders/1/5
        [ResponseType(typeof(Order))]
        public IHttpActionResult GetOrder(int id)
        {
            var order = _businessLogic.GetOne(id);
            if (order == null)
            {
                return NotFound();
            }
            return Ok(order);
        }

        // PUT: api/Orders/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutOrder(int id, Order order)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.Update(order);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Orders
        [ResponseType(typeof(Order))]
        public IHttpActionResult PostOrder(Order order)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.Add(order);
            return CreatedAtRoute("DefaultApi", new { id = order.OrderId }, order);
        }

        // DELETE: api/Orders/5
        [ResponseType(typeof(Order))]
        public IHttpActionResult DeleteOrder(int id)
        {
            var ok = _businessLogic.Delete(id);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.OK);
        }
    }
}