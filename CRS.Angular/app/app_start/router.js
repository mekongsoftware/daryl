// document: https://ui-router.github.io/docs/0.3.1/#/api/ui.router.router.$urlRouter
// sample: https://angular-ui.github.io/ui-router/sample/#/about
mainApp
.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/home');

    $stateProvider

    // login

    .state("signup", {
        url: '/Signup',
        controller: 'signupCtrl',
        templateUrl: "/app/authentication/signup.html"
    })
    .state("login", {
        url: '/Login',
        controller: 'loginCtrl',
        templateUrl: "/app/authentication/login.html",
        //params: {action: 'login'}
    })
    .state("logout", {
        url: '/Logout',
        controller: 'loginCtrl',
        templateUrl: "/app/authentication/login.html",
        params: {action: 'logout'}
    })
    .state("goodbye", {
        url: '/Goodbye',
        templateUrl: "/app/views/goodbye.html",
    })
    .state("create-accounts", {
        url: '/CreateAccounts',
        controller: 'loginCtrl',
        template: "Account created"
    })

    // main app
    .state("home", {
        url: '/',
        //controller: 'homeCtrl',
        templateUrl: "/app/views/home.html"
    })
    .state("about", {
        url: '/About',
        templateUrl: "/app/views/about.html"
    })
    .state("contact", {
        url: '/Contact',
        templateUrl: "/app/views/contact.html"
    })

    .state("admin", {
        url: '/Admin',
        //controller: 'ordersCtrl',
        template: "/app/admin/admin.html"
    })


    .state("order-main", {
        url: '/Overview',
        templateUrl: "/app/order/table-list.html",
    })
    .state("order-list-kitchen", {
        url: '/KitchenView',
        controller: 'orderListCtrl',
        templateUrl: "/app/order/order-list-kitchen.html",
        params: {tableId: null}
    })
    .state("order-list-kitchen-by-category", {
        url: '/KitchenItemView',
        controller: 'orderListCtrl',
        templateUrl: "/app/order/order-list-kitchen-by-category.html",
        params: { tableId: null }
    })
    .state("order-list-cashier", {
        url: '/OpenOrders',
        controller: 'orderListCtrl',
        templateUrl: "/app/order/order-list-cashier.html",
        params: { tableId: null }
    })
    .state("order-create-order", {
        url: '/CreateOrder',
        controller: 'orderCtrl',
        templateUrl: "/app/order/create-order.html",
        params: { orderId: null, tableId: null, action: 'update-bill' }
    })

    .state("order-print-bill", {
        url: '/PrintBill',
        controller: 'orderCtrl',
        templateUrl: "/app/order/order-print.html",
        params: { orderId: null, tableId: null, action: 'print-bill' }
    })
    .state("order-close-bill", {
        url: '/CloseBill',
        controller: 'orderCtrl',
        templateUrl: "/app/order/order-close.html",
        params: { orderId: null, tableId: null, action: 'close-bill' }
    })
    .state("help", {
        url: '/Help',
        templateUrl: "/app/views/help.html"
    })

    .state("setup", {
        url: '/Setup',
        //controller: 'restaurantCtrl',
        template: "Setup is used to change user, product and restaurant settings. Not implemented yet."
    })

    .state("test", {
        url: '/',
        templateUrl: "/app/z_dev_test/test.html"
    })
    .state("category", {
        url: '/admin/category',
        controller: 'categoryCtrl',
        templateUrl: "/app/admin/category/category.html"
    })
    .state("product", {
        url: '/admin/product',
        controller: 'productCtrl',
        templateUrl: "/app/admin/product/product.html"
    })
    .state("addon", {
        url: '/admin/addon',
        controller: 'addonCtrl',
        templateUrl: "/app/admin/addon/addon.html"
    })
    .state("table-admin", {
        url: '/admin/table',
        controller: 'tableAdminCtrl',
        templateUrl: "/app/admin/table/table.html"
    })
    .state("restaurant", {
        url: '/admin/restaurant',
        controller: 'restaurantCtrl',
        templateUrl: "/app/admin/restaurant/restaurant.html"
    })
    ;
    /*
.state("product", {
    url: '/admin/product',
    //controller: 'ordersCtrl',
    template: "/app/admin/product/product.html"
})
.state("user", {
    url: '/admin/user',
    //controller: 'ordersCtrl',
    template: "/app/admin/user/user.html"
})

.state("table", {
    url: '/admin/table',
    //controller: 'ordersCtrl',
    template: "/app/admin/store/store.html"
});
*/

    // use the HTML5 History API, must include in main html: <base href="/app/">
    //$locationProvider.html5Mode(true);

});
