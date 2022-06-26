mainApp

.config(function ($httpProvider) {
    $httpProvider.interceptors.push('authInterceptorService');
})

.run(['authService', function (authService) {
    authService.fillAuthData();
}])

.run(['$rootScope', '$state', '$stateParams', 'authService', function ($rootScope, $state, $stateParams, authService) {
    $rootScope.$state = $state;
    $rootScope.$stateParams = $stateParams;

    $rootScope.appName = 'My Angular App';
    $rootScope.appVersion = '0.01';

    $rootScope.user = authService.user;
    $rootScope.$watch('user.isLoggedIn', function (newValue, oldValue) {
        if (!$rootScope.user.isLoggedIn) {
            $state.go('login');
        }
        else {
            $state.go('home');
        }
    });
}])
