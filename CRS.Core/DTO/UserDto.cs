using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRS.Core.DTO
{
    public class UserDto
    {
        public System.Guid UserId { get; set; }
        public Nullable<System.Guid> AuthenticationId { get; set; }
        public Nullable<int> RestaurantId { get; set; }
        public string Login { get; set; }
    }
}
