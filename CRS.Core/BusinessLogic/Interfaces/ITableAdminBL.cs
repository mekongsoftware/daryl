using System.Linq;
using CRS.Core.Models;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface ITableAdminBl
    {
        IQueryable<Table> GetAll(int restaurantId);
        Table GetOne(Guid id);
        bool Update(Table table);
        bool Add(Table table);
        bool Delete(Guid id);

    }
}