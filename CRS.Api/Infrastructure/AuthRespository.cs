using System;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using CRS.Api.Infrastructure;
using CRS.Core.ModelsEF;
using System.Linq;

public class UserSession
{

}

public class AuthRepository : IDisposable
{
    private AuthContext _authContext;

    private UserManager<IdentityUser> _userManager;

    private RestaurantEntities appDb = new RestaurantEntities();

    public AuthRepository()
    {
        _authContext = new AuthContext();
        _userManager = new UserManager<IdentityUser>(new UserStore<IdentityUser>(_authContext));
    }

    public async Task<IdentityResult> RegisterUser(UserModel userModel)
    {
        IdentityUser user = new IdentityUser
        {
            UserName = userModel.UserName
        };

        var result = await _userManager.CreateAsync(user, userModel.Password);

        return result;
    }

    // DK added
    // todo: remove direct acess to appDB, plase it in Core BL
    public int RegisterNewUsers()
    {
        // create accounts from [Users] using Identity framework (add entries to AspNetUsers table)
        var newUsers = appDb.Users.Where(x => x.AuthenticationId == null).ToList();
        foreach (var appUser in newUsers)
        {
            var user = new IdentityUser();
            user.UserName = appUser.Login;
            var result = _userManager.Create(user, appUser.Password);
            if (result.Succeeded)
            {
                appUser.AuthenticationId = new Guid(user.Id);
                appDb.SaveChanges();
            }
        };

        // add user roles based on default login name
        var users = appDb.AspNetUsers.ToList();
        foreach (var user in users)
        {
            var loginName = user.UserName.Substring(0, user.UserName.IndexOf('@'));
            
            switch (loginName)
            {
                case "Waiter":
                    _userManager.AddToRole(user.Id, "OrderTaker");
                    _userManager.AddToRole(user.Id, "Deliverer");
                    break;
                case "Preparer":
                    _userManager.AddToRole(user.Id, "Preparer");
                    _userManager.AddToRole(user.Id, "Deliverer");
                    break;
                case "Deliverer":
                    _userManager.AddToRole(user.Id, "Deliverer");
                    break;
                case "Demo":
                case "Cashier":
                case "Manager":
                case "Owner":
                case "Admin":
                    _userManager.AddToRole(user.Id, "Cashier");
                    _userManager.AddToRole(user.Id, "ClientAdmin");
                    _userManager.AddToRole(user.Id, "Deliverer");
                    _userManager.AddToRole(user.Id, "Manager");
                    _userManager.AddToRole(user.Id, "OrderTaker");
                    _userManager.AddToRole(user.Id, "Owner");
                    _userManager.AddToRole(user.Id, "Preparer");
                    break;
            }
        }
        return newUsers.Count;
    }


    public async Task<IdentityUser> FindUser(string userName, string password)
    {
        IdentityUser user = await _userManager.FindAsync(userName, password);

        return user;
    }

    public void Dispose()
    {
        _authContext.Dispose();
        _userManager.Dispose();

    }
}