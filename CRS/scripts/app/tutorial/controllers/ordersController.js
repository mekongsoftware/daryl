'use strict';
app.controller('ordersController', ['$scope', 'ordersService', function ($scope, ordersService) {
    $scope.data = [
         { orderID: 10248, customerName: "Taiseer Joudeh", shipperCity: "Amman", isShipped: true },
         { orderID: 10249, customerName: "Ahmad Hasan", shipperCity: "Dubai", isShipped: false },
         { orderID: 10250, customerName: "Tamer Yaser", shipperCity: "Jeddah", isShipped: false },
         { orderID: 10251, customerName: "Lina Majed", shipperCity: "Abu Dhabi", isShipped: false },
         { orderID: 10252, customerName: "Yasmeen Rami", shipperCity: "Kuwait", isShipped: true }
    ];

    $scope.orders = [];

    ordersService.getOrders().then(function (results) {

        $scope.orders = results.data;

    }, function (error) {
        //alert(error.data.message);
    });
}]);