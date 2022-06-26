using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using CRS.Core.Models;
using CRS.Core.BusinessLogic;
using CRS.Core.Helpers;




namespace CRS.Core.BusinessLogic
{
    public class AddonBl: IAddonBl
    {
        private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();

        public IQueryable<Addon> GetAll(int restaurantId)
        {
            //return db.Addons;
            return db.Addons.Where(x => x.RestaurantId == restaurantId).Project().To<Addon>().OrderBy(x=>x.CategoryId);
        }

        public Addon GetOne(Guid id)
        {
            var addon = db.Addons.Find(id);
            return (addon == null) 
                ? null 
                : XMapper<Addon>.Map(addon);
        }

        public bool Update(Addon addon)
        {
            db.Entry(addon).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!AddonExists(addon.AddonId))
                {
                    return false;
                }
                else
                {
                    throw;
                }
            }
            return true;
        }

        public bool Add(Addon addon)
        {
            try
            {
                var efAddon = XMapper<ModelsEF.Addon>.Map(addon);
                db.Addons.Add(efAddon);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        public bool Delete(Guid id)
        {
            var addon = db.Addons.Find(id);
            if (addon == null)
            {
                return false;
            }
            try
            {
                db.Addons.Remove(addon);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        private bool AddonExists(Guid id)
        {
            return db.Addons.Count(e => e.AddonId == id) > 0;

        }
    }
}