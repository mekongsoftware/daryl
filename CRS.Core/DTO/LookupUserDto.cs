using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRS.Core.DTO
{
    public class LookupUserDto
    {
        public Guid UserId { get; set; }

        public string Login { get; set; }
        public string Password { get; set; }
        public string Name { get; set; }
    }
}
