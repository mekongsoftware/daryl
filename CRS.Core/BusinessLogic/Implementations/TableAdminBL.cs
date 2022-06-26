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
    public class TableAdminBl: ITableAdminBl
    {
        private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();

        public IQueryable<Table> GetAll(int restaurantId)
        {
            //return db.Tables;
            return db.Tables
                .Where(x => x.RestaurantId == restaurantId).Project()
                .To<Table>()
                .OrderBy(x=>x.LocationY)
                .ThenBy(x=>x.LocationX);
        }

        public Table GetOne(Guid id)
        {
            var Table = db.Tables.Find(id);
            return (Table == null) 
                ? null 
                : XMapper<Table>.Map(Table);
        }

        public bool Update(Table table)
        {
            db.Entry(table).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TableExists(table.TableId))
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

        public bool Add(Table table)
        {
            try
            {
                var efTable = XMapper<ModelsEF.Table>.Map(table);
                db.Tables.Add(efTable);
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
            var Table = db.Tables.Find(id);
            if (Table == null)
            {
                return false;
            }
            try
            {
                db.Tables.Remove(Table);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }
        private bool TableExists(Guid id)
        {
            return db.Tables.Count(e => e.TableId == id) > 0;

        }
    }
}