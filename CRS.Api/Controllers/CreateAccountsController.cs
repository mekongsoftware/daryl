using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Threading.Tasks;
using CRS.Core.ModelsEF;

namespace CRS.Controllers
{
    public class CreateAccountsController : ApiBaseController
    {
        private RestaurantEntities appDb = new RestaurantEntities();

        // GET: api/CreateAccounts
        public IEnumerable<string> Get()
        {
            AuthRepository authRepository = new AuthRepository();
            var count = authRepository.RegisterNewUsers();
            var result = string.Format("{0} account has been created.", count);
            return new string[] { "CreateAccount", result };
        }

    //    // GET: api/CreateAccounts/5
    //    public string Get(int id)
    //    {
    //        return "value";
    //    }

    //    // POST: api/CreateAccounts
    //    public void Post([FromBody]string value)
    //    {
    //        AuthRepository authRepository = new AuthRepository();
    //        authRepository.RegisterNewUsers();
    //    }
    //}

    //    // PUT: api/CreateAccounts/5
    //    public void Put(int id, [FromBody]string value)
    //    {
    //    }

    //    // DELETE: api/CreateAccounts/5
    //    public void Delete(int id)
    //    {
    //    }
    }
}
