'use strict';
mainApp
.factory('authService', ['$http', '$q', 'localStorageService', function ($http, $q, localStorageService) {

    //var serviceBase = 'http://ngauthenticationapi.azurewebsites.net/';
    var serviceBase = '/';
    var authServiceFactory = {};

    var _user = {
        isLoggedIn: false,
        name: '',
        accessLevel: '0'
    };

    var _saveRegistration = function (registration) {
        _logOut();
        return $http.post(serviceBase + 'api/account/register', registration).then(function (response) {
            return response;
        });
    };

    var _login = function (loginData) {
        var data = "grant_type=password&username=" + loginData.userName + "&password=" + loginData.password;
        var deferred = $q.defer();
        $http.post(serviceBase + 'token', data, { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
            .success(function (response) {
                //localStorageService.set('authorizationData', { token: response.access_token, userName: loginData.userName });
                localStorageService.set('authorizationData', {
                    token: response.access_token,
                    userId: response.userId,
                    userName: response.userName,
                    accessLevel: response.accessLevel,
                    restaurantId: response.restaurantId,
                    restaurantName: response.restaurantName
                });
                _user.isLoggedIn = true;
                _user.name = loginData.userName;
                _user.accessLevel = 1; // loginData.accessLevel;
                console.log(response);
                deferred.resolve(response);

            })
            .error(function (err, status) {
                _logOut();
                deferred.reject(err);
            });
        return deferred.promise;
    };

    var _logOut = function () {

        localStorageService.remove('authorizationData');

        _user.isLoggedIn = false;
        _user.name = "";
        _user.accessLevel = 0;

    };

    var _fillAuthData = function () {

        var authData = localStorageService.get('authorizationData');
        if (authData) {
            _user.isAuth = true;
            _user.userName = authData.userName;
        }

    }

    authServiceFactory.saveRegistration = _saveRegistration;
    authServiceFactory.login = _login;
    authServiceFactory.logOut = _logOut;
    authServiceFactory.fillAuthData = _fillAuthData;
    authServiceFactory.user = _user;

    return authServiceFactory;
}]);

