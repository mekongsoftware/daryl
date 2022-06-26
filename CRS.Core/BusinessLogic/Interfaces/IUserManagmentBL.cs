using System.Linq;
using CRS.Core.Models;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface IUserManagementBL
    {
        IQueryable<User> GetAll(int restaurantId);
        User GetOne(Guid id);
        bool Update(User user);
        bool Add(User user);
        bool Delete(Guid id);
        bool CreateAspNetIdentityAccounts();
    }
}