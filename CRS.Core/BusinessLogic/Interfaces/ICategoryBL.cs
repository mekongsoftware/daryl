using System.Linq;
using CRS.Core.Models;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface ICategoryBl
    {
        IQueryable<Category> GetAll(int restaurantId);
        Category GetOne(Guid id);
        bool Update(Category category);
        bool Add(Category category);
        bool Delete(Guid id);

    }
}