using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using CRS.Core.DTO;
using CRS.Core.Helpers;

namespace CRS.Core.BusinessLogic
{
    public class UserBL : IUserBL
    {
        private ModelsEF.RestaurantEntities _db = new ModelsEF.RestaurantEntities();

        public bool Login(string login, string password)
        {
            return _db.Users.FirstOrDefault(x => x.Login.ToLower() == login.ToLower() && x.Password == password && x.IsActive.Value) != null;
        }
        public UserDto FindUser(string login, string password)
        {
            var user = _db.Users.FirstOrDefault(x => x.Login.ToLower() == login.ToLower() && x.Password == password && x.IsActive.Value);
            return XMapper<UserDto>.Map(user);
        }

        public bool Add(UserDto user)
        {
            throw new NotImplementedException();
        }

        public bool Delete(Guid id)
        {
            throw new NotImplementedException();
        }

        public bool GetUserAccess()
        {
            throw new NotImplementedException();
        }

        public bool Update(UserDto user)
        {
            throw new NotImplementedException();
        }

        public bool UpdateUserAccess()
        {
            throw new NotImplementedException();
        }

        public SessionDto GetSessionDetail(Guid authenticationId)
        {
            var user = _db.Users.FirstOrDefault(x => x.AuthenticationId == authenticationId); // && x.IsActive.Value != true);
            if (user == null)
            {
                throw new Exception(string.Format("User does not contain Authencication '{0}'", authenticationId));
            }
            var restaurant = _db.Restaurants.FirstOrDefault(x => x.RestaurantId == user.RestaurantId); // && x.IsActive.Value != true);
            if (restaurant == null)
            {
                throw new Exception(string.Format("Restaurant does not contain user info'{0}'", authenticationId));
            }
            var session = new SessionDto();
            session.UserId = user.UserId;
            session.UserName = user.NameEn;
            session.UserPages = new List<string>();
            session.RestaurantId = restaurant.RestaurantId;
            session.RestaurantName = restaurant.NameEn;
            session.IsFoodTruck = restaurant.IsFoodTruck ?? false;
            session.RestaurantComponents = "";
            session.UserDefaultLanguage = user.DefaultLanguage ?? "en";
            session.RestaurantDefaultLanguage = "en";
            session.CurrentLanguage = "";
            session.AccessLevel = 2;
            return session;
        }
    }
}
