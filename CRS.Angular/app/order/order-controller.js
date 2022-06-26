// todo: multiple gets


// create new module here, other file for this module, use this: 
// angular.module("order")

angular.module("order", [])
.controller('orderCtrl', [
'$state', '$stateParams', '$rootScope', '$scope', '$http', 'cartFactory', '$sessionStorage', 'STATUS',
function ($state, $stateParams, $rootScope, $scope, $http, cartFactory, $sessionStorage, STATUS) {
    var guessPayments = function (amount) {
        var amounts = [];
        var payment = 0.00;
        // $100
        while (payment < amount) payment += 100;
        if (amounts.indexOf(payment) < 0) amounts.push(payment);
        // $50
        while (payment > amount) payment -= 50;
        payment += 50;
        if (amounts.indexOf(payment) < 0) amounts.push(payment);
        // $20
        while (payment > amount) payment -= 20;
        payment += 20;
        if (amounts.indexOf(payment) < 0) amounts.push(payment);
        // $10
        while (payment > amount) payment -= 10;
        payment += 10;
        if (amounts.indexOf(payment) < 0) amounts.push(payment);
        //$5
        while (payment > amount) payment -= 5;
        payment += 5;
        if (amounts.indexOf(payment) < 0)
            amounts.push(payment);
        return amounts.sort(function (a, b) { return a - b; });
    };
    var getSuggestedTips = function (amount, renderedAmount) {
        var tips = [];
        tips.push({ percent: '5%', amount: (amount * 0.05).toFixed(2) });
        tips.push({ percent: '10%', amount: (amount * 0.10).toFixed(2) });
        tips.push({ percent: '15%', amount: (amount * 0.15).toFixed(2) });
        tips.push({ percent: '20%', amount: (amount * 0.20).toFixed(2) });
        tips.push({ percent: 'No Tip', amount: (0).toFixed(2) });
        if (renderedAmount - amount > 0) {
            tips.push({ percent: 'Keep the Change', amount: (renderedAmount - amount).toFixed(2) });
        }
        return tips;
    };
    var getPaymentTypes = function () {
        var types = [];
        types.push("Cash");
        types.push("Card");
        types.push("Void");
        return types;
    }
    var createOrderNumber = function () {
        var now = new Date;
        var orderNumber = String.format("{0}{1}",
            ('0' + now.getHours()).slice(-2),
            ('0' + now.getMinutes()).slice(-2));
        return orderNumber;
    };

    //var createRange = function (size) {
    //    var options = [];
    //    for (var i = 0; i < size; i++) {
    //        options.push(i + 1);
    //    }
    //    return options;
    //};

    // should this be here or on server?
    var mapOrderStatusId = function (statusText) {
        var sId = STATUS.OrderPreOrderStatusId;
        switch (statusText) {
            case 'OrderConfirmed':
                statusId = STATUS.OrderOrderConfirmedStatusId;
                break;
            case 'PreOrder':
                statusId = STATUS.OrderPreOrderStatusId;
                break;
            case 'Void':
                statusId = STATUS.OrderCancelledStatusId;
                break;
            case 'Paid':
                statusId = STATUS.OrderPaidStatusId;
                break;
        }
        return statusId;
    };

    var createNewOrder = function () {
        return {
            orderNumber: createOrderNumber(),
            orderStaffId: $rootScope.authData.userId,
            serviceStaffId: $rootScope.authData.userId,
            createdBy: $rootScope.authData.userId,
            //orderTypeId: null,      
            splitBillEvenFlag: null,
            restaurantId: $rootScope.authData.restaurantId,
            tableId: $scope.tableId,
            taxAmount: 0,
            groupChargeAmount: 0,
            orderProducts: []
        };
    };

    var populateCurrentOrder = function () {
        $scope.currentOrder.orderAmount = cartFactory.getTotalAmount();
    }

    $scope.cancel = function () {
        if (!confirm('Are you sure to cancel?')) {
            return;
        }
        cartFactory.clearCartContent();
        // todo: foodtruck main order page
        $state.go('order-main');
    };



    $scope.splitChange = function (increment) {
        $scope.splitInto += increment;
        if ($scope.splitInto > 20) {
            $scope.splitInto = 20;
        }
        if ($scope.splitInto < 1) {
            $scope.splitInto = 1;
        }
    };

    $scope.splitBillEvenOptions = [
        { value: null, name: 'Shared' },
        { value: true, name: 'Split Even' },
        { value: false, name: 'Split by Seat' }
    ];
    //$scope.partySizeOptions = createRange($scope.partySize);

    $scope.setRenderedAmount = function (amount) {
        $scope.amountRendered = amount.toFixed(2);
        $scope.changeAmount = ($scope.amountRendered - $scope.grandTotal - $scope.currentOrder.tipAmount).toFixed(2);
    };

    $scope.setTipAmount = function (amount) {
        $scope.currentOrder.tipAmount = amount;
        $scope.changeAmount = ($scope.amountRendered - $scope.grandTotal - $scope.currentOrder.tipAmount).toFixed(2);
    };

    $scope.paymentTypeChange = function () {
        if ($scope.paymentType != 'Void') {
            $scope.paymentIsVoided = false;
        }
        else {
            $scope.paymentIsVoided = true;
            $scope.amountRendered = 0;
            $scope.changeAmount = 0;
            $scope.currentOrder.tipAmount = 0;
        }
    };

    $scope.getOrder = function () {
        if ($scope.orderId == null) {
            $scope.currentOrder = createNewOrder();
            cartFactory.clearCartContent();
            return;
        }
        $http({ url: __env.apiUrl('Orders/GetOrder/') + $scope.orderId })
        .then(function (response) {
            $scope.paidTime = new Date;     // check for the action, paid or close time
            $scope.currentOrder = response.data;
            $scope.currentOrder.itemsLocked = true;  // check status -- not needed use isLocked
            $scope.currentOrder.taxAmount = $scope.currentOrder.orderAmount * $scope.currentOrder.taxRatePercent / 100;
            $scope.currentOrder.groupChargeAmount = 0;
            if ($rootScope.restaurant.groupPeople > 0 && $rootScope.restaurant.groupPeople <= $scope.currentOrder.partySize) {
                $scope.currentOrder.groupChargeAmount =
                    ($scope.currentOrder.orderAmount + $scope.currentOrder.taxAmount)
                    * ($rootScope.restaurant.groupChargePercent / 100);
            }
            $scope.grandTotal = ($scope.currentOrder.orderAmount + $scope.currentOrder.taxAmount + $scope.currentOrder.groupChargeAmount).toFixed(2);
            $scope.amountRendered = $scope.grandTotal;
            $scope.quickPayments = guessPayments($scope.grandTotal);
            $scope.suggestedTips = getSuggestedTips($scope.grandTotal, $scope.amountRendered);
            cartFactory.setCartContent($scope.currentOrder.orderProducts);
        });
    }

    $scope.saveAs = function (statusText) {
        $scope.currentOrder.statusId = mapOrderStatusId(statusText);
        populateCurrentOrder();
        var params = $scope.currentOrder;
        params.orderProducts = cartFactory.data.orderProducts;

        // create new
        $http.post(__env.apiBaseUrl + 'orders', params)
        .success(function (data, status, headers, config) {
            cartFactory.clearCartContent();
            // todo: foodtruck main order page
            $state.go('order-main');
        })
        .error(function (data, status, headers, config) {
            console.log(data);
        });
    };
    $scope.submitPayment = function (order) {
        order.cashierStaffId = $rootScope.authData.userId;
        if ($scope.paymentMethod == 'Void') {
            order.statusId = mapOrderStatusId('Void')
        }
        else {
            order.statusId = mapOrderStatusId('Paid');
            order.paymentMethod = $scope.paymentType;
        }
        var url = __env.apiUrl('Orders/CloseOrder');
        $http.post(url, order)
        .then(function (response) {
            $state.go('order-list-cashier');
        }), function (error) {
            console.log(error);
        };
    }

    $scope.isShowCart = true;
    $scope.isShowProducts = false;
    $scope.isShowAddons = false;

    $scope.tableId = $stateParams.tableId;
    $scope.orderId = $stateParams.orderId;
    $scope.action = $stateParams.action;

    $scope.currentOrder = {};
    $scope.showCustom = false;
    $scope.splitInto = 1;
    $scope.quickPayments = [];
    $scope.suggestedTips = [];
    $scope.currentOrder.tipAmount = 0;
    $scope.grandTotal = 0;
    $scope.amountRendered = 0;
    $scope.changeAmount = 0;
    $scope.paymentTypes = getPaymentTypes();
    $scope.paymentType = $scope.paymentTypes[0];
    $scope.paymentIsVoided = false;

    // restore state info on page refresh or page go back
    if ($scope.tableId == null && $scope.orderId == null) {
        var stateParams = $sessionStorage.StateParams;
        var stateName = $sessionStorage.StateName;
        // came back from another state
        if (stateParams.tableId == null && stateParams.orderId == null) {
            $state.go('order-list-cashier');
            return;
        }
        $state.go(stateName, stateParams);
    }

    // todo: these watches cause un-necessary GET
    $scope.$watch('currentOrder.orderProducts', function (data) {
        if (data) {
            $scope.currentOrder.orderProducts = cartFactory.data.orderProducts;
        }
    });

    $scope.$watch('lookup', function (data) {
        if (data) {
            $scope.getOrder();
        }
    });

    $scope.$watch('amountRendered', function (data) {
        if (data) {
            $scope.suggestedTips = getSuggestedTips($scope.grandTotal, $scope.amountRendered);
        }
    });

    $scope.$watch('restaurant', function (data) {
        if (data) {
            $scope.currentOrder.taxRatePercent = $rootScope.restaurant.taxPercent;
        }
    });


}]);