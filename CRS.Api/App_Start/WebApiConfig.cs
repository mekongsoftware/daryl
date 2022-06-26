using System.Web.Http;
using System.Net.Http.Formatting;
using Newtonsoft.Json.Serialization;
using Newtonsoft.Json;
using System.Net.Http;
using System.Web.Http.Routing;

namespace CRS
{
    public static class WebApiConfig
    {
        /// <summary>
        /// Web API config, called by Owin's Startup
        /// </summary>
        /// <param name="config"></param>
        public static void Register(HttpConfiguration httpConfig)
        {
            // Web API configuration and services
            httpConfig.MapHttpAttributeRoutes();

            var routes = httpConfig.Routes;

            // action api
            //routes.MapHttpRoute(
            //    name: "DefaultApiWithAction",
            //    routeTemplate: "api/{controller}/{action}/{id}",
            //    defaults: new { id = RouteParameter.Optional }
            //);
            // default routing
            routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );


            // http://stackoverflow.com/questions/9499794/single-controller-with-multiple-get-methods-in-asp-net-web-api
            //http://stackoverflow.com/questions/13596391/web-api-routing-api-controller-action-id-dysfunctions-api-controller

            //routes.MapHttpRoute("DefaultApiWithId", "Api/{controller}/{id}", new { id = RouteParameter.Optional }, new { id = @"\d+" });

            // match: http://localhost:49818/api/orders/GetAllOrders?id=d5162a6f-6c20-432d-9f83-f0680d523667
            //routes.MapHttpRoute("DefaultApiWithAction", "Api/{controller}/{action}/{id}", new { id = RouteParameter.Optional }, new { id = @"\d+" });
            //routes.MapHttpRoute("DefaultApiGet", "Api/{controller}", new { action = "Get" }, new { httpMethod = new HttpMethodConstraint(HttpMethod.Get) });
            //routes.MapHttpRoute("DefaultApiPost", "Api/{controller}", new { action = "Post" }, new { httpMethod = new HttpMethodConstraint(HttpMethod.Post) });

            #region Customize JSON serialization
            // to return camelCase
            var formatters = httpConfig.Formatters;
            formatters.Clear();
            formatters.Add(new JsonMediaTypeFormatter());
            formatters.JsonFormatter.SerializerSettings = new JsonSerializerSettings
            {
                ContractResolver = new CamelCasePropertyNamesContractResolver(),
                Formatting = Formatting.Indented
            };

            // fix JSON serialization self reference error
            formatters.JsonFormatter.SerializerSettings.PreserveReferencesHandling = Newtonsoft.Json.PreserveReferencesHandling.Objects;
            #endregion
        }
    }
}
