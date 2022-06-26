'use strict';
mainApp
.factory('lookupFactory', ['$http', function ($http) {
    return {
        getData: function () {
            return $http({
                mehtod: 'GET',
                url: __env.apiBaseUrl + 'lookup',
            });
        }
    }
}])