//http://bitoftech.net/2014/06/09/angularjs-token-authentication-using-asp-net-web-api-2-owin-asp-net-identity/

var app = angular.module('AngularAuthApp', ['ngRoute', 'LocalStorageModule', 'angular-loading-bar']);

app.config(function ($routeProvider) {

    $routeProvider.when("/home", {
        controller: "homeController",
        templateUrl: "views/home.html"
    });

    $routeProvider.when("/login", {
        controller: "loginController",
        templateUrl: "views/login.html"
    });

    $routeProvider.when("/signup", {
        controller: "signupController",
        templateUrl: "views/signup.html"
    });

    $routeProvider.when("/orders", {
        controller: "ordersController",
        templateUrl: "views/orders.html"
    });

    $routeProvider.otherwise({ redirectTo: "/home" });
});

app.config(function ($httpProvider) {
    $httpProvider.interceptors.push('authInterceptorService');
});


app.run(['authService', function (authService) {
    authService.fillAuthData();
}]);

