angular.module("order", [
     "ngResource"
     , "ngRoute"
     , "customFilters"
     , "cart"
])

.constant("URL", {
    category: "http://localhost:13478/api/categories/",
    product: "http://localhost:13478/api/products/"
})

.constant("VIEW", {
    orderHome: 'orderHome',
    editOrder: 'editOrder',
    addServices: 'addServices',
    makePayment: 'makePayment',
    selectOrder: 'selectOrder',
    newOrder: 'newOrder'
})

.controller("orderCtrl", function ($rootScope, $scope, $http, URL, VIEW) {
    // http://stackoverflow.com/questions/15299850/angularjs-wait-for-multiple-resource-queries-to-complete

    $scope.displayMode = 'searchOrder';
    $scope.currentOrder = null;
    $scope.orderSelected = false;

    $scope.currentView = '';

    $scope.hideView = function (view) {
        return $scope.displayMode != view;
    };

    $scope.data = {};

    $scope.currentOrder = {};
    $scope.tempOrder = {};


    $http.get(URL.category).then(function (response) {
        $scope.data.categories = response.data;
    });

    $http.get(URL.product).then(function (response) {
        $scope.data.products = response.data;
    });

    $scope.searchOrder = function () {
        $scope.displayMode = 'searchOrder';
    };

    $scope.orderHome = function () {
        $scope.displayMode = 'orderHome';
    };

    $scope.editOrder = function () {
        $scope.tempOrder = $scope.currentOrder;
        $scope.displayMode = 'orderInput';
    };

    $scope.newOrder = function () {
        $scope.tempOrder = {
            orderId: 0,
            orderNumber: '0',
            orderStatus: 'Unpaid',
            scheduledDate: new Date(),
            performedDate: new Date(),
            customerName: 'Select Customer',
            technicianName: 'Select Technician',
            isWalkedIn: false,
            note: ''
        };
        $scope.displayMode = 'orderInput';
    };

    $scope.selectOrder = function (order) {
        $scope.orderSelected = true;
        $scope.currentOrder = order;
        $scope.displayMode = 'orderHome';
    }

    $scope.saveOrder = function () {
        // save currentOrder here...
        $scope.currentOrder = $scope.tempOrder;
        $scope.orderSelected = true;
        $scope.displayMode = 'orderHome';
    }

    $scope.payOrder = function () {
        $scope.displayMode = 'paymentInput';
    };

    $scope.addServices = function () {
        $scope.displayMode = 'addServices';
    };

    $scope.init = function () {
        $('#scheduledDate, #performedDate')
            .click(function () { alert('clicked'); });

        $('#scheduledDate, #performedDate')
                    .datepicker()
                    .on('changeDate', function (ev) {
                        //var id = ev.target.id;
                        //var isValid = false;
                        //isValid =  (id=='fromDate')  
                        //    ? ev.date.valueOf() <= $('#toDate').val()
                        //    : ev.date.valueOf() >= $('#fromDate').val()
                        //if (!isValid) {
                        //    console.log($('#fromDate').val());
                        //    console.log($('#toDate').val());
                        //    alert('From Date must be earlier than To Date');
                        //}
                    })
    }


    $scope.init();
});

