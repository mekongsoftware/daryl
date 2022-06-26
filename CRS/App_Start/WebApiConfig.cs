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

            // default routing
            httpConfig.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{id}",
                defaults: new { id = RouteParameter.Optional }
            );

            // stackoverflow.com/questions/9569270/custom-method-names-in-asp-net-web-api
            // httpConfig.Routes.MapHttpRoute(
            //    name: "WithActionApi",
            //      routeTemplate: "api/{controller}/{action}/{id}",
            //    defaults: new { action="Get", id = RouteParameter.Optional }
            //);


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
