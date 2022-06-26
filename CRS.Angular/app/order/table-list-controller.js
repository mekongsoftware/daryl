angular.module("order")
.controller('tableListCtrl', ['$state', '$http', '$rootScope', '$scope', '$filter', '$http', 
function ($state, $http, $rootScope, $scope, $filter, $http) {
    $scope.tables = [];
    $scope.getData= function () {
        //$state.go($state.$current, null, { reload: true });
        $http.get(__env.apiBaseUrl + '/TableOverview')
        .then(function (response) {
            $scope.tables = response.data;
            $scope.tableRows = $filter('chunk')($scope.tables, 6);
        });
    };


    $scope.deleteAllOrders = function () {
        if (!confirm(String.format('Delete all orders?'))) {
            return;
        }
        $http({
            method: 'DELETE',
            url: __env.apiUrl('Orders/DeleteRestaurantOrders')
        })
        .then(function () {
            $scope.getData();
        });
    };


    $scope.selectTable = function (tableId, openOrderCount) {
        if (openOrderCount > 0) {
            $state.go('order-list-cashier', { tableId: tableId });
        }
        else {
            $state.go('order-create-order', { tableId: tableId });
        }
    }

    $scope.getData();
}])