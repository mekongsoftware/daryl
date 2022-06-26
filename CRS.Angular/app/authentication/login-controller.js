'use strict';
mainApp
.controller('loginCtrl', ['$scope', '$rootScope', '$state', '$stateParams', 'authService', 'lookupFactory',
    function ($scope, $rootScope, $state, $stateParams, authService, lookupFactory) {

    $scope.loginData = {
        userName: "",
        password: ""
    };

    $scope.showDemoCredential = false;
    $scope.message = "";
    
    $scope.login = function () {
        authService.login($scope.loginData).then(function (response) {
            // more work on back end to return user name, access level...
            $rootScope.authData = authService.getAuthData();
            // load lookup tables
            lookupFactory.getData().then(function (response) {
                $rootScope.lookup = response.data;
            });
        },
         function (err, status) {
             $scope.message = err ? err.error_description : String.format('{0} is unreachable.', window.__env.baseUrl);
         });
    };

    $scope.logout = function () {
        authService.logout();
        $rootScope.authData = authService.getAuthData();
    };
    
    if ($stateParams.action == 'logout') {
        $scope.logout();
    }
}]);