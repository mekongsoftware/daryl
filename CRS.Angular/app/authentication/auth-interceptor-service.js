'use strict';
mainApp
.factory('authInterceptorService',
['$q', '$location', '$sessionStorage',
function ($q, $location, $sessionStorage) {

    var authInterceptorServiceFactory = {};

    var _request = function (config) {
        config.headers = config.headers || {};
        var authData = $sessionStorage.authData;
        if (authData) {
            config.headers.Authorization = 'Bearer ' + authData.access_token;
            config.headers['x-user-id'] = authData.userId;
            config.headers['x-user-name'] = authData.userName;
            config.headers['x-access-level'] = authData.accessLevel;
            config.headers['x-restaurant-id'] = authData.restaurantId;
            config.headers['x-restaurant-name'] = authData.restaurantName;
            config.headers["x-user-pages"] = authData.userPages;
            config.headers["x-restaurant-components"] = authData.restaurantComponents;
            config.headers["x-user-default-language"] = authData.userDefaultLanguage;
            config.headers["x-restaurant-default-language"] = authData.restaurantDefaultLanguage;
            config.headers["x-current-language"] = authData.currentLanguage;
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