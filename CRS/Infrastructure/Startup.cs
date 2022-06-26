// http://bitoftech.net/2014/06/01/token-based-authentication-asp-net-web-api-2-owin-asp-net-identity/

using Microsoft.Owin;
using Owin;
using System;
using System.Web.Http;
using Microsoft.Owin.Security.OAuth;
using System.Web.Mvc;
using System.Web.Routing;

[assembly: OwinStartup(typeof(CRS.Infrastructure.Startup))]
namespace CRS.Infrastructure
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureOAuth(app);

            var httpConfig = new HttpConfiguration();
            
            // api help
            GlobalConfiguration.Configure(WebApiConfig.Register);
            AreaRegistration.RegisterAllAreas();

            // configure Owin
            WebApiConfig.Register(httpConfig);
            app.UseWebApi(httpConfig);
        }

        public void ConfigureOAuth(IAppBuilder app)
        {
            OAuthAuthorizationServerOptions OAuthServerOptions = new OAuthAuthorizationServerOptions()
            {
                AllowInsecureHttp = true,
                TokenEndpointPath = new PathString("/token"),       // generate tokens path: http://localhost:port/token
                AccessTokenExpireTimeSpan = TimeSpan.FromDays(1),   // token expiry: 24 hours
                Provider = new SimpleAuthorizationServerProvider()  //validate the credentials for users asking for tokens in custom class
            };

            // Token Generation
            app.UseOAuthAuthorizationServer(OAuthServerOptions);
            app.UseOAuthBearerAuthentication(new OAuthBearerAuthenticationOptions());

        }
    }
}