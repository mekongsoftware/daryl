using System.Linq;
using CRS.Core.Models;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface IProductBl
    {
        IQueryable<Product> GetAll(int restaurantId);
        Product GetOne(Guid id);
        bool Update(Product Product);
        bool Add(Product Product);
        bool Delete(Guid id);

    }
}