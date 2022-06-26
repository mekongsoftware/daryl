'use strict';
mainApp
.factory('authService',
['$http', '$q', '$sessionStorage',
function ($http, $q, $sessionStorage) {

    var _authData = {
        isLoggedIn: false
    };

    var _logout = function () {
        //sessionStorageService.remove('authorizationData');
        $sessionStorage.$reset();
        _authData = {};
    };

    return {

        authData: _authData,
        getAuthData: function () { return _authData; },

        saveRegistration: function (registration) {
            _logout();
            return $http.post(window.__env.apiBaseUrl + 'account/register', registration).then(function (response) {
                return response;
            });
        },

        login: function (loginData) {
            var data = "grant_type=password&username=" + loginData.userName + "&password=" + loginData.password;
            var deferred = $q.defer();
            $http.post(window.__env.tokenUrl, data, { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } })
                .success(function (response) {
                    _authData = response;
                    //console.log(_authData);
                    //sessionStorageService.set('authorizationData', {
                    //    authData: _authData
                    //});
                    $sessionStorage.authData = _authData;
                    deferred.resolve(response);

                })
                .error(function (err, status) {
                    deferred.reject(err);
                });
            return deferred.promise;
        },

        logout: function () {
            //sessionStorageService.remove('authorizationData');
            $sessionStorage.$reset();
            _authData = {};
            console.log('logged out...');
        },

        fillAuthData: function () {
            var authData = $sessionStorage.authData; // sessionStorageService.get('authorizationData');
            if (authData) {
                authData.isLoggedIn = true;
                _authData = authData;
            }
        },

        logout: function () { _logout() }
    }
}]);

