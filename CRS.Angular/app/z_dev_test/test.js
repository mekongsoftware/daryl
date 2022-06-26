angular.module("test", [
    //'admin.product'
    //, 'admin.category'
    //, 'admin.addon'
])


.filter('testproductName', function ($filter) {
    return function (productId, products) {
        console.log(products);
        if (products.length == 0) return '?';
        var name = products.map(function (e) { e.productId }).indexOf(productId).name;
        return name;
    }
})

.controller('testCtrl', ['$scope', '$http',
function ($scope, $http, deferredObj) {
    $scope.productId = 1;
    $scope.products = [];
    $http.get('http://localhost').then(function (response) {
        $scope.products = [
            { id: 1, name: 'one' },
            { id: 2, name: 'two' },
            { id: 3, name: 'three' },
            { id: 4, name: 'four' },
        ];
        $scope.dataLoaded = true;
    }).catch(function () {
        $scope.products = [
            { id: 1, name: 'one' },
            { id: 2, name: 'two' },
            { id: 3, name: 'three' },
            { id: 4, name: 'four' },
        ];
    })
}])

/*
.filter('productName', function ($filter) {
    return function (id, p) {
        console.log(p[0]);
        var name = p.map(function (e) { e.productId }).indexOf(id).name;
        return 'name';
    }
})
.controller("orderListCtrl", ['$http', '$filter', '$scope', 'lookupFactory', 'productModel',
function ($http, $filter, $scope, lookupFactory, productModel) {
    $scope.orders = [];
    $scope.lookup = {};
    $scope.productModel = productModel;
    lookupFactory.getData().then(function (response) {
        $scope.lookup = response.data;
        $scope.productModel = response.data;
    });

    $http({
        mehtod: 'GET',
        url: __env.apiBaseUrl + 'orders',
        // params: 'p=1, sortby=createddate:desc',
        //headers: { 'Authorization': 'Token token=....' }
    })
    .then(function (response) {
        $scope.orders = response.data;
    }), (function (error) {
        console.log(error);
    });


}])

*/