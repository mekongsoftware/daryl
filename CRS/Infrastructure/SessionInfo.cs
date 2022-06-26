using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net.Http.Headers;

namespace CRS.Infrastructure
{

    using System.Net.Http.Headers;

    public class SessionInfo
    {
        public string UserId { get; set; }
        public string UserName { get; set; }
        public int AccessLevel { get; set; }
        public int RestaurantId { get; set; }
        public string RestaurantName { get; set; }

        public Dictionary<string, string> GetUserDetail(IdentityUser user)
        {
            var userDetail = new Dictionary<string, string>();
            userDetail.Add("userId", user.Id);
            userDetail.Add("userName", "User Name");
            userDetail.Add("accessLevel", "3");
            userDetail.Add("restaurantId", "101");
            userDetail.Add("restaurantName", "Pho so 1 Hawthorn");
            return userDetail;
        }

        public SessionInfo() { }


        public SessionInfo(HttpRequestHeaders headers)
        {
            try
            {

                UserId = HeaderValue<string>(headers, "x-user-id");
                UserName = HeaderValue<string>(headers, "x-user-name");
                AccessLevel = HeaderValue<int>(headers, "x-access-level");
                RestaurantId = HeaderValue<int>(headers, "x-restaurant-id");
                RestaurantName = HeaderValue<string>(headers, "x-restaurant-name");
            }
            catch
            {
                UserId = "0";
                UserName = "Guess User";
                AccessLevel = 0;
                RestaurantId = 100;
                RestaurantName = "No Restaurant Associated";
            }
        }

        public static T HeaderValue<T>(HttpRequestHeaders headers, string key)
        {
            var value = default(T);
            IEnumerable<string> keys = null;
            if (headers.TryGetValues(key, out keys))
            {
                value = (T)Convert.ChangeType(keys.FirstOrDefault(), typeof(T));
                
            }
            return value;
        }
    }
}