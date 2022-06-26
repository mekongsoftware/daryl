using System.Linq;
using CRS.Core.Models;
using CRS.Core.DTO;
using System;

namespace CRS.Core.BusinessLogic
{
    public interface IUserBL
    {

        bool Login(string login, string password);
        UserDto FindUser(string login, string password);
        bool Update(UserDto user);
        bool Add(UserDto user);
        bool Delete(Guid id);
        bool UpdateUserAccess();
        bool GetUserAccess();

       SessionDto GetSessionDetail(Guid authenticationId);

    }
}