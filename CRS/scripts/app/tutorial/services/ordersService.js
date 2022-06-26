'use strict';
app.factory('ordersService', ['$http', function ($http) {
 
    //var serviceBase = 'http://ngauthenticationapi.azurewebsites.net/';
    var serviceBase = '/';
    var ordersServiceFactory = {};
 
    var _getOrders = function () {
 
        return $http.get(serviceBase + 'api/test').then(function (results) {
            return results;
        });
    };
 
    ordersServiceFactory.getOrders = _getOrders;
 
    return ordersServiceFactory;
 
}]);