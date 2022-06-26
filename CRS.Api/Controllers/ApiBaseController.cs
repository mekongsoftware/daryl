using System.Web;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using CRS.Core.DTO;
using CRS.Core.BusinessLogic;
using CRS.Api.Infrastructure;

namespace CRS.Controllers
{
    public class ApiBaseController : ApiController
    {
        protected SessionInfo Session;

        public ApiBaseController() : base()
        {
            Session = new SessionInfo(HttpContext.Current.Request.Headers);
        }
    }
}
