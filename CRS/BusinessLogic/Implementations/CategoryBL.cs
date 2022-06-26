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
    public class CategoryBL: ICategoryBL
    {
        private Models_Ef.RestaurantEntities db = new Models_Ef.RestaurantEntities();

        public IQueryable<Category> GetAll(int restaurantId)
        {
            //return db.Categories;
            return db.Categories.Where(x => x.RestaurantId == restaurantId).Project().To<Category>();
        }

        public Category GetOne(int id)
        {
            var category = db.Categories.Find(id);
            return (category == null) 
                ? null 
                : Mapper<Category>.Map(category);
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
                var efCategory = Mapper<Models_Ef.Category>.Map(category);
                db.Categories.Add(efCategory);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        public bool Delete(int id)
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
        private bool CategoryExists(int id)
        {
            return db.Categories.Count(e => e.CategoryId == id) > 0;

        }
    }
}