using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CRS.Core.Models
{
    public class User
    {
        public Guid UserId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string IdentityId { get; set; }
        public string Login { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
        public string Phone1 { get; set; }
        public string Phone2 { get; set; }
        public Nullable<Guid> UserType { get; set; }
        public string Note { get; set; }
        public Nullable<bool> IsActive { get; set; }
        public Nullable<System.DateTime> LastLogin { get; set; }
    }
}