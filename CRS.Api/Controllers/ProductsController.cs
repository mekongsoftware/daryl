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
using CRS.Core.Models;
using CRS.Core.BusinessLogic;
using CRS.Api.Infrastructure;

namespace CRS.Controllers
{
    public class ProductsController : ApiBaseController
    {
        //private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();
        private ProductBl _businessLogic = new ProductBl();

        // GET: api/Products
        public IQueryable<Product> GetProducts()
        {
            return _businessLogic.GetAll(Session.RestaurantId);
        }

        // GET: api/Products/5
        [ResponseType(typeof(Product))]
        public IHttpActionResult GetProduct(Guid id)
        {
            var product = _businessLogic.GetOne(id);
            if (product == null)
            {
                return NotFound();
            }
            return Ok(product);
        }

        // PUT: api/Products/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutProduct(Guid id, Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.Update(product);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Products
        [ResponseType(typeof(Product))]
        public IHttpActionResult PostProduct(Product product)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.Add(product);
            return CreatedAtRoute("DefaultApi", new { id = product.ProductId }, product);
        }

        // DELETE: api/Products/5
        [ResponseType(typeof(Product))]
        public IHttpActionResult DeleteProduct(Guid id)
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