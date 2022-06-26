using CRS.Core.BusinessLogic;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections.Specialized;

namespace CRS.Api.Infrastructure
{
    public class SessionInfo
    {
        public int UserId { get; set; }
        public string UserName { get; set; }
        public int RestaurantId { get; set; }
        public string RestaurantName { get; set; }
        public int AccessLevel { get; set; }
        public string UserPages { get; set; }
        public string RestaurantComponents { get; set; }
        public string UserDefaultLanguage { get; set; }
        public string CurrentLanguage { get; set; }
        
        public static Dictionary<string, string> GetSessionDetail(IdentityUser user)
        {
            var businessLogic = new UserBL();
            var sessionDetail = businessLogic.GetSessionDetail(new Guid(user.Id.ToUpper()));

            var userDetail = new Dictionary<string, string>();
            userDetail.Add("userId", sessionDetail.UserId.ToString());
            userDetail.Add("userName", sessionDetail.UserName);
            userDetail.Add("accessLevel", sessionDetail.AccessLevel.ToString());
            userDetail.Add("restaurantId", sessionDetail.RestaurantId.ToString());
            userDetail.Add("restaurantName", sessionDetail.RestaurantName);
            userDetail.Add("userPages", "ABC,DEF,WHATEVER, NOTYETDETERMINED");
            userDetail.Add("restaurantComponents",sessionDetail.RestaurantComponents);
            userDetail.Add("userDefaultLanguage", sessionDetail.RestaurantDefaultLanguage);
            userDetail.Add("restaurantDefaultLanguage", sessionDetail.UserDefaultLanguage);
            userDetail.Add("currentLanguage", sessionDetail.UserDefaultLanguage);
            userDetail.Add("isLoggedIn", "true");

            return userDetail;
        }

        public SessionInfo(NameValueCollection headers)
        {
            UserId = HeaderValue<int>(headers, "x-user-id");
            UserName = HeaderValue<string>(headers, "x-user-name");
            RestaurantId = HeaderValue<int>(headers, "x-restaurant-id");
            RestaurantName = HeaderValue<string>(headers, "x-restaurant-name");
            AccessLevel = HeaderValue<int>(headers, "x-access-level");
            UserPages = HeaderValue<string>(headers, "x-user-pages");
            RestaurantComponents = HeaderValue<string>(headers, "x-restaurant-components");
            UserDefaultLanguage = HeaderValue<string>(headers, "x-default-languages");
            CurrentLanguage = HeaderValue<string>(headers, "x-current-language");
        }

        static T HeaderValue<T>(NameValueCollection headers, string key)
        {
            var value = default(T);
            try
            {
                var stringValue = headers.Get(key).Split(',').First();
                value = (T)Convert.ChangeType(stringValue, typeof(T));
            } 
            catch
            {
                value = default(T);
            }
            return value;
        }
    }
}