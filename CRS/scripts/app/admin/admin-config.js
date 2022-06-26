// ui-router document:  http://www.ng-newsletter.com/posts/angular-ui-router.html
// ui-router example:   https://scotch.io/tutorials/angular-routing-using-ui-router


var routerApp = angular.module('routerApp', [
        'ui.router'
        , 'ngResource'
        , 'ngMessages'
        , 'helper.filters'
        , 'admin.category'
        , 'admin.restaurant'
        , 'dirPagination'
]);

routerApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/admin');

    $stateProvider

    /// HOME STATES AND NESTED VIEWS ========================================
    .state('admin', {
        url: '/admin',
        templateUrl: 'admin-home-partial.html'
    })

    // product states 
    .state('admin.product', {
        url: '/product',
        templateUrl: '/Scripts/app/admin/product/product.html',
        controller: 'productCtrl'
    })

    .state('admin.restaurant', {
        url: '/restaurant',
        templateUrl: 'restaurant/restaurant.html',
        controller: 'restaurantCtrl'
    })

    .state('admin.employee', {
        url: '/employee',
        templateUrl: 'employee/employee.html',
        controller: function ($scope) {
            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
        }
    })

    .state('admin.category', {
        url: '/category',
        templateUrl: '/Scripts/app/admin/category/category.html',
        controller: 'categoryCtrl'
    })

    .state('admin.store', {
        url: '/store',
        templateUrl: 'store/store.html',
        controller: function ($scope) {
            $scope.dogs = ['Bernese', 'Husky', 'Goldendoodle'];
        }
    })
});

