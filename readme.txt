Nuget Packages:

	Install-Package Microsoft.AspNet.WebApi.Owin 
	Install-Package Microsoft.Owin.Host.SystemWeb


	Install-Package Microsoft.AspNet.Identity.Owin -Version 2.0.1
	Install-Package Microsoft.AspNet.Identity.EntityFramework 

	Install-Package Microsoft.Owin.Cors 

OWIN notes

	- global.asax.cs is not used
	- startup.cs is used instead
	- json format is configured via HttpConfiguration in WebApi
	- API help page is registered in startup.Configure

References:

	Token Based Bearer Auth
	http://bitoftech.net/2014/06/09/angularjs-token-authentication-using-asp-net-web-api-2-owin-asp-net-identity/

	Token Based Auth
	http://c-sharpcorner.com/UploadFile/ff2f08/token-based-authentication-using-Asp-Net-web-api-owin-and-i/

	Data mapping, Project() linq extension
	http://www.devtrends.co.uk/blog/stop-using-automapper-in-your-data-access-code

Deployment note:
	WebAPI configuration errors on <handler>
		http://stackoverflow.com/questions/20048486/http-error-500-19-and-error-code-0x80070021
		Go to Windows Features, .NET Framework 4.6 Advanced Services, WCF check on Http Activation
	Login Fail for SQL
		http://stackoverflow.com/questions/7698286/login-failed-for-user-iis-apppool-asp-net-v4-0
		Use SQL Authentication, user id=sa;password=*********** instead of Integrated Security=true
		connectionString="metadata=res://*/ModelsEF.RestaurantModel.csdl|res://*/ModelsEF.RestaurantModel.ssdl|res://*/ModelsEF.RestaurantModel.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=nuc5\sqlexpress;initial catalog=Restaurant;user id=sa;password=pw4sql;MultipleActiveResultSets=True;App=EntityFramework&quot;" 
	Timeout Error
		Turn off firewall on IIS machine, using CMD admin mode run this:
		NetSh Advfirewall set allprofiles state off		