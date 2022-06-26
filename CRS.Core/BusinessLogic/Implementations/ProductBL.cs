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
    public class ProductBl: IProductBl
    {
        private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();

        public IQueryable<Product> GetAll(int restaurantId)
        {
            //return db.Products;
            return db.Products.Where(x => x.RestaurantId == restaurantId).Project().To<Product>().OrderBy(x=>x.CategoryId);
        }

        public Product GetOne(Guid id)
        {
            var Product = db.Products.Find(id);
            return (Product == null) 
                ? null 
                : XMapper<Product>.Map(Product);
        }

        public bool Update(Product product)
        {
            db.Entry(product).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ProductExists(product.ProductId))
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

        public bool Add(Product product)
        {
            try
            {
                var efProduct = XMapper<ModelsEF.Product>.Map(product);
                db.Products.Add(efProduct);
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
            var Product = db.Products.Find(id);
            if (Product == null)
            {
                return false;
            }
            try
            {
                db.Products.Remove(Product);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        private bool ProductExists(Guid id)
        {
            return db.Products.Count(e => e.ProductId == id) > 0;

        }
    }
}