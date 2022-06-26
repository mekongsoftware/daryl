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
    public class TablesAdminController : ApiBaseController
    {
        //private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();
        private TableAdminBl _businessLogic = new TableAdminBl();

        // GET: api/Tables
        public IQueryable<Table> GetTables()
        {
            return _businessLogic.GetAll(Session.RestaurantId);
        }

        // GET: api/Tables/5
        [ResponseType(typeof(Table))]
        public IHttpActionResult GetTable(Guid id)
        {
            var Table = _businessLogic.GetOne(id);
            if (Table == null)
            {
                return NotFound();
            }
            return Ok(Table);
        }

        // PUT: api/Tables/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutTable(Guid id, Table Table)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.Update(Table);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Tables
        [ResponseType(typeof(Table))]
        public IHttpActionResult PostTable(Table Table)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.Add(Table);
            return CreatedAtRoute("DefaultApi", new { id = Table.TableId }, Table);
        }

        // DELETE: api/Tables/5
        [ResponseType(typeof(Table))]
        public IHttpActionResult DeleteTable(Guid id)
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