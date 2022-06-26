'use strict';
mainApp
.controller('loginController', ['$scope', '$rootScope', '$state', 'authService', function ($scope, $rootScope, $state, authService) {

    $scope.loginData = {
        userName: "",
        password: ""
    };

    $scope.message = "";

    $scope.login = function () {
        authService.login($scope.loginData).then(function (response) {
            // more work on back end to return user name, access level...
            $rootScope.user = authService.user;
            // does not work...
            // $state.go('about');
        },
         function (err) {
             $scope.message = err.error_description;
         });
    };

    $scope.logout = function () {
        authService.logout().then(function() {
            $rootScope.user = authService.user;
        });
    };
}]);