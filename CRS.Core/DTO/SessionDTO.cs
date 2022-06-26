using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRS.Core.DTO
{
    public class SessionDto
    {
        /// <summary>
        /// Logged in UserId
        /// </summary>
        public Guid UserId { get; set; }
        /// <summary>
        /// Logged in Name
        /// </summary>
        public string UserName { get; set; }
        /// <summary>
        /// Pages (codes) that use can access (use to render pages/menu)
        /// </summary>
        public List<string> UserPages { get; set; }
        /// <summary>
        /// RestaurantId that user belong to
        /// </summary>
        public int RestaurantId { get; set; }
        /// <summary>
        /// Restaurant name
        /// </summary>
        public string RestaurantName { get; set; }
        public bool IsFoodTruck { get; set; }
        /// <summary>
        /// Components that restaurant purchased (use to render pages/menu)
        /// </summary>
        public string RestaurantComponents { get; set; }
        /// <summary>
        /// User default language
        /// </summary>
        public string UserDefaultLanguage { get; set; }
        /// <summary>
        /// Current language
        /// </summary>
        public string RestaurantDefaultLanguage { get; set; }
        /// <summary>
        /// Current language
        /// </summary>
        public string CurrentLanguage { get; set; }

        public int AccessLevel { get; set; }
    }
}
