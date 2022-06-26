using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using CRS.Core.DTO;
using CRS.Core.BusinessLogic;
using CRS.Api.Infrastructure;

namespace CRS.Controllers
{
    //[Authorize]
    public class TableOverviewController : ApiBaseController
    {
        private OrderBl _businessLogic = new OrderBl();
        [ResponseType(typeof(LookupTableDto))]
        public IEnumerable<LookupTableDto> Get()
        {
            //testing
            //_restaurantId = 102;
            //_language = "Vi";

            return _businessLogic.GetTableOverview(Session.RestaurantId, Session.CurrentLanguage);
        }
    }
}