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
    public class UserManagementBL // : IUserManagementBL
    {
        private ModelsEF.RestaurantEntities db = new ModelsEF.RestaurantEntities();

        public IQueryable<User> GetAll(int restaurantId)
        {
            //return db.Addons;
            return db.Users.Where(x => x.RestaurantId == restaurantId).Project().To<User>(); //.OrderBy(x=>x.CategoryId);
        }

        public User GetOne(Guid id)
        {
            var user = db.Users.Find(id);
            return (user == null)
                ? null
                : XMapper<User>.Map(user);
        }

        public bool Update(User user)
        {
            db.Entry(user).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(user.UserId))
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

        public bool Add(User user)
        {
            try
            {
                var efUser = XMapper<ModelsEF.User>.Map(user);
                db.Users.Add(efUser);
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
            var user = db.Users.Find(id);
            if (user == null)
            {
                return false;
            }
            try
            {
                db.Users.Remove(user);
                db.SaveChanges();
            }
            catch
            {
                return false;
            }
            return true;
        }

        public bool GetNewUserAccounts()
        {
            // call identity register for all user without identityId
            var newUsers = db.Users.Where(x => x.AuthenticationId == null);
            return true;
        }
        private bool UserExists(Guid id)
        {
            return db.Users.Count(e => e.UserId == id) > 0;

        }
    }
}