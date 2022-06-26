angular.module("order")
.controller('orderListCtrl', ['$state', '$stateParams', '$http', '$filter', '$rootScope', '$scope', '$interval', 'STATUS',
function ($state, $stateParams, $http, $filter, $rootScope, $scope, $interval, STATUS) {

    // set warning class, based on order time
    // todo: get from table for configuration
    var warning = function (minutes) {
        var level = 0;
        if (minutes > 15) {
            level = 2;
        } else if (minutes > 10) {
            level = 1;
        }
        return level;
    };

    var msInterval = $rootScope.restaurant.refreshIntervalSeconds * 1000;     
    var reloadInterval = $interval(function () {
        $scope.reload();
    }, msInterval);
    
    $scope.showHideDetail = function () {
        $scope.showDetail = !$scope.showDetail;
    };

    $scope.applyCategoryFilter = function (orderProduct) {
        var isIncluded = true;
        if ($scope.selectedCategories.length > 0) {
            var i = $rootScope.lookup.products.map(function (el) { return el.productId; }).indexOf(orderProduct.productId);
            var productCategoryId = $rootScope.lookup.products[i].categoryId;
            isIncluded = $scope.selectedCategories.indexOf(productCategoryId) >= 0;
        }
        orderProduct.isInSelectedCategories = isIncluded;
    }

    // set lateness, next status
    var setWarning = function (orders) {
        var minutes = 0;
        for (var i = 0; i < orders.length; i++) {
            minutes = $filter('ellapsedMinutes')(orders[i].orderTime);
            orders[i].lateness = warning(minutes);
            var products = orders[i].orderProducts;
            for (var j = 0; j < products.length; j++) {
                minutes = $filter('ellapsedMinutes')(products[j].orderTime);
                products[j].lateness = warning(minutes);
                var addons = products[j].orderProductAddons;
                for (var k = 0; k < addons.length; k++) {
                    minutes = $filter('ellapsedMinutes')(addons[k].orderTime);
                    addons[k].lateness = warning(minutes);
                }
            }
        }
    };
    
    // execute when Category Filter button clicked
    $scope.categoryFilter = function () {
        $scope.showCategories = true;
        $scope.refreshActive = false;
    }

    // executes when categories are selected
    $scope.selectCategories = function () {
        $scope.showCategories = false;
        $scope.refreshActive = true;
        for (var i = 0; i < $scope.orders.length; i++) {
            for (var j = 0; j < $scope.orders[i].orderProducts.length; j++) {
                $scope.applyCategoryFilter($scope.orders[i].orderProducts[j]);
            }
        }
    }
    
    $scope.updateOrderStatus = function (orderId, statusId) {
        $http({
            method: 'POST',
            url: __env.apiUrl(String.format('orders/UpdateOrderStatus/{0}/{1}', orderId, statusId))
        })
        .then(function (response) {
            $scope.reload();
        }), function (error) {
            console.log(error);
        };
    };

    $scope.updateOrderProductStatus = function (orderProductId, statusId) {
        $http({
            method: 'POST',
            url: __env.apiUrl(String.format('orders/UpdateOrderProductStatus/{0}/{1}', orderProductId, statusId))
        })
        .then(function (response) {
            $scope.reload();
        }), function (error) {
            console.log(error);
        };
    };

    $scope.updateOrderProductStatuses = function (statusId, orderProducts) {
        var url = __env.apiUrl(String.format('orders/UpdateOrderProductStatuses/{0}', statusId));
        var data = { statusId: statusId, orderProducts: orderProducts[0] };
        //$http({
        //    method: 'POST',
        //    url: __env.apiUrl(String.format('orders/UpdateOrderProductStatuses', statusId)),
        //    params: data
        //})
        $http.post(url, orderProducts)
        .then(function (response) {
            $scope.reload();
        }), function (error) {
            console.log(error);
        };
    };

    $scope.updateOrderProductAddonStatus = function (orderProductAddonId, statusId) {
        $http({
            method: 'POST',
            url: __env.apiUrl(String.format('orders/UpdateOrderProductAddonStatus/{0}/{1}', orderProductAddonId, statusId))
        })
        .then(function (response) {
            $scope.reload();
        }), function (error) {
            console.log(error);
        };
    };

    $scope.getAllOpenOrders = function() {
        $scope.tableId = null;
        $scope.getOpenOrders();
    }

    $scope.getOpenOrders = function () {
        $http({
            method: 'GET',
            url: __env.apiUrl(String.format('orders/GetOpenOrders/{0}', $scope.tableId))
        })
        .then(function (response) {
            $scope.orders = response.data;
            setWarning($scope.orders);
            $scope.selectCategories();
        }), function (error) {
            console.log(error);
        };
    }

    $scope.edit = function (order) {
        //$state.go("order-create-order", { orderId: order.orderId });      
        $state.go("order-create-order", { orderId: order.orderId, notify: false });
    };

    $scope.createOrder = function (tableId) {
        $state.go('order-create-order', { tableId: tableId, notify: false });
    }

    $scope.checkOut = function (order) {
        if (!order.isLocked) {
            //if (order.statusId != STATUS.OrderCheckRequestedStatusId) {
                if (!confirm("You will not able to add item after print bill. Continue?")) {
                    return;
                }
        }
        $scope.updateOrderStatus(order.orderId, STATUS.OrderCheckRequestedStatusId);
        $state.refreshActive = false;
        $state.go("order-print-bill", { orderId: order.orderId, notify: false });
    };

    $scope.closeBill = function (order) {
        $state.refreshActive = false;
        $state.go("order-close-bill", { orderId: order.orderId, notify: false });
    };

    
    $scope.isDeletable = function (order) {
        return order.statusId == STATUS.OrderPreOrderStatusId;
    }

    $scope.deleteOrder = function (order) {
        //var table = $filter('lookupName')($rootScope.lookup.tables, 'tableId');
        var message = String.format('Delete order# {0}?', order.orderNumber)
        if (!confirm(message)) {
            return;
        }
        $http({
            method: 'DELETE',
            url: __env.apiUrl(String.format('Orders/DeleteOrder/{0}', order.orderId))
        })
        .then(function (response) {
            $scope.reload();
        }), function (error) {
            console.log(error);
        };
    };

    $scope.reload = function () {
        if ($scope.refreshActive) {
            $scope.getOpenOrders();
        }
    };

    $scope.$on('$destroy', function () {
        $interval.cancel(reloadInterval);
    });

    $scope.$watch('lookup.categories|filter:{selected:true}', function (nv) {
        if (nv === undefined) {
            return;
        }
        $scope.selectedCategories = nv.map(function (category) {
            return category.categoryId;
        });
    }, true);

    $scope.tableId = $stateParams.tableId;
    $scope.refreshActive = true;
    $scope.showDetail = false;
    $scope.showCategories = false;
    $scope.selectedCategories = [];
    $scope.orders = [];
    $scope.orderDefaultActions = [STATUS.OrderProcessingStatusId, STATUS.OrderProcessedStatusId, STATUS.OrderDeliveredStatusId];

    $scope.getOpenOrders();
}]);
