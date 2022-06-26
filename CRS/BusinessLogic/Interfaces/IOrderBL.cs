using System.Linq;
using CRS.Models;

namespace CRS.BusinessLogic
{
    public interface IOrderBL
    {
        IQueryable<Order> GetAll(int restaurantId);
        Order GetOne(int id);
        bool Update(Order Order);
        bool Add(Order Order);
        bool Delete(int id);

    }
}