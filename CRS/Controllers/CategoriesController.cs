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
using CRS.Infrastructure;

namespace CRS.Controllers
{
    public class CategoriesController : ApiController
    {
        //private Models_Ef.RestaurantEntities db = new Models_Ef.RestaurantEntities();
        private CategoryBL _businessLogic = new CategoryBL();

        // GET: api/Categories
        public IQueryable<Category> GetCategories()
        {
            var session = new Infrastructure.SessionInfo(this.Request.Headers);
            var restaurantId = session.RestaurantId;

            return _businessLogic.GetAll(restaurantId);
        }

        // GET: api/Categories/5
        [ResponseType(typeof(Category))]
        public IHttpActionResult GetCategory(int id)
        {
            var category = _businessLogic.GetOne(id);
            if (category == null)
            {
                return NotFound();
            }
            return Ok(category);
        }

        // PUT: api/Categories/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutCategory(int id, Category category)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.Update(category);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Categories
        [ResponseType(typeof(Category))]
        public IHttpActionResult PostCategory(Category category)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.Add(category);
            return CreatedAtRoute("DefaultApi", new { id = category.CategoryId }, category);
        }

        // DELETE: api/Categories/5
        [ResponseType(typeof(Category))]
        public IHttpActionResult DeleteCategory(int id)
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