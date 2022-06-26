using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.Identity.EntityFramework;
using CRS.Core.ModelsEF;
namespace CRS.Api.Infrastructure
{
    public class AuthContext: IdentityDbContext<IdentityUser>
    {
        private RestaurantEntities _db = new RestaurantEntities();

        public string StoreName { get; set; }
        public AuthContext(): base("RestaurantAuth")
        {
            
        }
    }
}