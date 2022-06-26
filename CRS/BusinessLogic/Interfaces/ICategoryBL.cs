using System.Linq;
using CRS.Models;

namespace CRS.BusinessLogic
{
    public interface ICategoryBL
    {
        IQueryable<Category> GetAll(int restaurantId);
        Category GetOne(int id);
        bool Update(Category category);
        bool Add(Category category);
        bool Delete(int id);

    }
}