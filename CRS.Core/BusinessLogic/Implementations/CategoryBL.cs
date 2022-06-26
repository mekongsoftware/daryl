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
    public class CategoryBl: ICategoryBl
    {
        private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();

        public IQueryable<Category> GetAll(int restaurantId)
        {
            //return db.Categories;
            return db.Categories.Where(x => x.RestaurantId == restaurantId).Project().To<Category>();
        }

        public Category GetOne(Guid id)
        {
            var category = db.Categories.Find(id);
            return (category == null) 
                ? null 
                : XMapper<Category>.Map(category);
        }

        public bool Update(Category category)
        {
            db.Entry(category).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!CategoryExists(category.CategoryId))
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

        public bool Add(Category category)
        {
            try
            {
                var efCategory = XMapper<ModelsEF.Category>.Map(category);
                db.Categories.Add(efCategory);
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
            var category = db.Categories.Find(id);
            if (category == null)
            {
                return false;
            }
            try
            {
                db.Categories.Remove(category);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        private bool CategoryExists(Guid id)
        {
            return db.Categories.Count(e => e.CategoryId == id) > 0;

        }
    }
}