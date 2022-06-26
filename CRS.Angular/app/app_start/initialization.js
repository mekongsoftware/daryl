mainApp

.config(function ($httpProvider, $locationProvider) {
    $httpProvider.interceptors.push('authInterceptorService');
    $locationProvider.html5Mode(true);
})

.run(['authService', function (authService) {
    authService.fillAuthData();
}])

.run(['$rootScope', '$http', '$state', '$stateParams', '$sessionStorage', '$window', 'authService', 'lookupFactory',
    function ($rootScope, $http, $state, $stateParams, $sessionStorage, $window, authService, lookupFactory) {
        var w = angular.element($window);
        
        //w.on('beforeunload', function (e) {
        //    //return e.preventDefault();
        //    //return 'Please do not refresh the page.';       // this message does not display in Chrome, at least
        //});
        
        // page refresth: restore session authdata, reload lookup table and language file 
        $rootScope.restoreSession = function () {
            var authData = $sessionStorage.authData;
            var language = authData ? authData.currentLanguage : 'en';
            $rootScope.authData = authData;
            if (authData != undefined && authData.isLoggedIn) {
                $http.get(String.format('/app/languages/translations-{0}.json.js', language))
                .then(function (result) {
                    $rootScope.translations = result.data;
                });
                lookupFactory.getData()
                .then(function (response) {
                    $rootScope.lookup = response.data;
                });
                $http({ url: __env.apiUrl('Orders/GetRestaurant/') })
                .then(function (response) {
                    $rootScope.restaurant = response.data;
                });
            }
        }

        $rootScope.$state = $state;
        $rootScope.$stateParams = $stateParams;

        // cannot prevent page refresh which cause 404 error on Azure 
        // so redirect to /home
        $rootScope.$on('$stateChangeStart', function (e, toState, toParams, fromState, fromParams) {
            if (toState.name == $sessionStorage.StateName) {
                e.preventDefault();
                if (toState.name != 'home') {
                    $state.go('home', { notify: false });
                }
            };
        });

        $rootScope.$on("$stateChangeError", console.log.bind(console));     // log when changing state has error

        // should store all states instead of current
        $rootScope.$on("$stateChangeSuccess", function (event, toState) {
            //if ($stateParams.tableId != null || $stateParams.orderId != null) {
                $sessionStorage.StateParams = $stateParams;
                $sessionStorage.StateName = $state.current.name;
            //}
        });

        $rootScope.appName = 'My Angular App';
        $rootScope.appVersion = '0.01';
        $rootScope.translations = [];
        $http.get('/app/languages/translations-en.json.js')
            .then(function (result) {
                $rootScope.translations = result.data;
            });

        $rootScope.authData = authService.authData;
        $rootScope.lookup = {}; // lookup tables

        $rootScope.restoreSession();

        $rootScope.$watch('authData.isLoggedIn', function (newValue, oldValue) {
            if (newValue == false || newValue === undefined) {
                $state.go('goodbye');
            }
            else {
                $rootScope.restoreSession();
                $state.go('order-main');   // todo: user home page
            }
        });

        $rootScope.printDiv = function (divId) {
            var contents = document.getElementById(divId).innerHTML;
            var popup = window.open('', '_blank', 'width=500, height=500');
            //var html = String.format('<html><head><link href="/libs/bootstrap/bootstrap-3.3.7.css" rel="stylesheet" media="all" /></head><body onload="window.print()">{0}</body></html>', contents);
            var html = String.format(
                '<html>'+
                '   <head>' +
                '       <link href="/libs/bootstrap/bootstrap-3.3.7.css" rel="stylesheet" media="all"/>' + 
                '       <link href="/resources/site.css" rel="stylesheet" media="all" />' +
                '   </head>' +
                '<body onload="window.print()">' +
                '{0}' +
                '</body></html>'
                , contents);
            popup.document.open();
            popup.document.write(html);
            popup.document.close();
        }
    }])
