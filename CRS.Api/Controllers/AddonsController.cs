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
    public class AddonsController : ApiBaseController
    {
        //private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();
        private AddonBl _businessLogic = new AddonBl();

        // GET: api/Addons
        public IQueryable<Addon> GetAddons()
        {
            return _businessLogic.GetAll(Session.RestaurantId);
        }

        // GET: api/Addons/5
        [ResponseType(typeof(Addon))]
        public IHttpActionResult GetAddon(Guid id)
        {
            var addon = _businessLogic.GetOne(id);
            if (addon == null)
            {
                return NotFound();
            }
            return Ok(addon);
        }

        // PUT: api/Addons/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutAddon(Guid id, Addon addon)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var ok = _businessLogic.Update(addon);
            if (!ok)
            {
                return NotFound();
            }
            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Addons
        [ResponseType(typeof(Addon))]
        public IHttpActionResult PostAddon(Addon addon)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            _businessLogic.Add(addon);
            return CreatedAtRoute("DefaultApi", new { id = addon.AddonId }, addon);
        }

        // DELETE: api/Addons/5
        [ResponseType(typeof(Addon))]
        public IHttpActionResult DeleteAddon(Guid id)
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