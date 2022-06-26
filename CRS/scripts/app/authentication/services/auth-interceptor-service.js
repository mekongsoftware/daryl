'use strict';
mainApp
.factory('authInterceptorService', ['$q', '$location', 'localStorageService', function ($q, $location, localStorageService) {

    var authInterceptorServiceFactory = {};

    var _request = function (config) {

        config.headers = config.headers || {};

        var authData = localStorageService.get('authorizationData');
        if (authData) {
            config.headers.Authorization = 'Bearer ' + authData.token;
            config.headers['x-user-id'] = authData.userId;
            config.headers['x-user-name'] = authData.userName;
            config.headers['x-access-level'] = authData.accessLevel;
            config.headers['x-restaurant-id'] = authData.restaurantId;
            config.headers['x-restaurant-name'] = authData.restaurantName;
        }

        return config;
    }

    var _responseError = function (rejection) {
        if (rejection.status === 401) {
            $location.path('/login');
        }
        return $q.reject(rejection);
    }

    authInterceptorServiceFactory.request = _request;
    authInterceptorServiceFactory.responseError = _responseError;

    return authInterceptorServiceFactory;
}]);