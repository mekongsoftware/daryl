using System.Threading.Tasks;
using Microsoft.Owin.Security.OAuth;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System.Security.Claims;
using System.Collections.Generic;
using Microsoft.Owin.Security;

namespace CRS.Api.Infrastructure
{
    public class SimpleAuthorizationServerProvider : OAuthAuthorizationServerProvider
    {
        public override async Task ValidateClientAuthentication(OAuthValidateClientAuthenticationContext context)
        {
            context.Validated();
        }

        public override async Task GrantResourceOwnerCredentials(OAuthGrantResourceOwnerCredentialsContext context)
        {
            AuthenticationProperties userProperties;
            using (AuthRepository _repo = new AuthRepository())
            {
                IdentityUser user = await _repo.FindUser(context.UserName, context.Password);

                if (user == null)
                {
                    context.SetError("invalid_grant", "The user name or password is incorrect.");
                    return;
                }

                userProperties = AddUserProperties(user);
            }

            var identity = new ClaimsIdentity(context.Options.AuthenticationType);

            //identity.AddClaim(new Claim("sub", context.UserName));
            //identity.AddClaim(new Claim("role", "user"));
            
            var ticket = new AuthenticationTicket(identity, userProperties);
            context.Validated(ticket);
        }

        

        public static AuthenticationProperties CreateProperties(IDictionary<string,string> data)
        {
            return new AuthenticationProperties(data);
        }
        public override Task TokenEndpoint(OAuthTokenEndpointContext context)
        {
            foreach (KeyValuePair<string, string> property in context.Properties.Dictionary)
            {
                context.AdditionalResponseParameters.Add(property.Key, property.Value);
            }
            return base.TokenEndpoint(context);
        }

        private AuthenticationProperties AddUserProperties(IdentityUser user)
        {
            //var session = SessionInfo();
            var userDetail = SessionInfo.GetSessionDetail(user);
            var addionalProperties = new AuthenticationProperties(userDetail);
            return addionalProperties;
        }


    }
}