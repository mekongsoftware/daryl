using System.Linq;
using CRS.Core.Models;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface IAddonBl
    {
        IQueryable<Addon> GetAll(int restaurantId);
        Addon GetOne(Guid id);
        bool Update(Addon product);
        bool Add(Addon product);
        bool Delete(Guid id);

    }
}