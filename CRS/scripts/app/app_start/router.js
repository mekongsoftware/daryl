// document: https://ui-router.github.io/docs/0.3.1/#/api/ui.router.router.$urlRouter
// sample: https://angular-ui.github.io/ui-router/sample/#/about
mainApp
.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/home');

    $stateProvider

    // login

    .state("signup", {
        url: '/signup',
        controller: 'signupController',
        templateUrl: "/scripts/app/authentication/views/signup.html"
    })
    .state("login", {
        url: '/login',
        controller: 'loginController',
        templateUrl: "/scripts/app/authentication/views/login.html"
    })
    .state("logout", {
        url: '/logout',
        controller: 'loginController',
        template: "/scripts/app/authentication/views/logout.html"
    })

    // main app
    .state("home", {
        url: '/',
        templateUrl: "/scripts/app/app-index-partial.html"
    })
    .state("about", {
        url: '/about',
        templateUrl: "/scripts/app/app-about-partial.html"
    })
    .state("admin", {
        url: '/admin',
        //controller: 'ordersController',
        template: "/scripts/app/admin/admin.html"
    })
    .state("restaurant", {
        url: '/admin/restaurant',
        controller: 'restaurantCtrl',
        templateUrl: "/scripts/app/admin/restaurant/restaurant.html"
    })
    .state("category", {
        url: '/admin/category',
        controller: 'categoryCtrl',
        templateUrl: "/scripts/app/admin/category/category.html"
    })
    ;
        /*
    .state("product", {
        url: '/admin/product',
        //controller: 'ordersController',
        template: "/scripts/app/admin/product/product.html"
    })
    .state("user", {
        url: '/admin/user',
        //controller: 'ordersController',
        template: "/scripts/app/admin/user/user.html"
    })

    .state("table", {
        url: '/admin/table',
        //controller: 'ordersController',
        template: "/scripts/app/admin/store/store.html"
    });
    */

    // use the HTML5 History API, must include in main html: <base href="/app/">
    //$locationProvider.html5Mode(true);

});
