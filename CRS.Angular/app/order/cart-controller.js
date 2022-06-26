angular.module("order")
.constant("addonAtiveClass", "btn-primary")
.constant("addonPageCount", 5)
.controller('cartCtrl', ['$state', '$http', '$rootScope', '$scope', 'addonAtiveClass', 'addonPageCount', 'cartFactory', 'STATUS',
function ($state, $http, $rootScope, $scope, activeClass, pageCount, cartFactory, STATUS) {

    $scope.cartData = cartFactory.data;

    var selectedCategory = null;

    $scope.selectedPage = 1;
    $scope.pageSize = pageCount;
    $scope.currentItemId = null;        // product internal id

    // todo: repeated, this function already exist in cartFactory
    $scope.total = function () {
        var total = 0;
        for (var i = 0; i < $scope.cartData.orderProducts.length; i++) {
            total += ($scope.cartData.orderProducts[i].price * $scope.cartData.orderProducts[i].quantity);
            for (var j = 0; j < $scope.cartData.orderProducts[i].orderProductAddons.length; j++) {
                total += $scope.cartData.orderProducts[i].orderProductAddons[j].price * $scope.cartData.orderProducts[i].quantity;
            }
        }
        return total;
    };

    $scope.itemCount = function () {
        var total = 0;
        for (var i = 0; i < $scope.cartData.length; i++) {
            total += $scope.cartData.orderProducts[i].quantity;
        }
        return total;
    };

    // reduce quantity by 1, it quantity is > 1, do nothing, it will be handled by removeItem()
    $scope.reduceQuantity = function (product) {
        var index = $scope.cartData.orderProducts.indexOf(product);
        $scope.currentItemIndex = index;
        // delete it, since the popup does not show
        if ($scope.cartData.orderProducts[index].quantity == 1) {
            cartFactory.removeProduct(product.id);
        }
    };

    // change product quantity
    $scope.changeQuantity = function (product, quantity) {
        var index = $scope.cartData.orderProducts.indexOf(product);
        $scope.cartData.orderProducts[index].quantity += quantity;
        if ($scope.cartData.orderProducts[index].quantity == 0) {
            cartFactory.removeProduct(product.id);
        }
    };

    // remove product (called when quantity is > 2)
    $scope.removeItem = function (removeOnly) {
        var index = $scope.currentItemIndex;
        if (!removeOnly) {
            var product = JSON.parse(JSON.stringify($scope.cartData.orderProducts[index]));
            product.quantity = 1;
            product.orderProductAddons = [];
            cartFactory.addProduct(product);
        }
        //var id = $scope.cartData.orderProducts[index].id;
        $scope.changeQuantity($scope.cartData.orderProducts[index], -1);   // reduce by one        
    };

    $scope.cancelProduct = function (orderProduct) {
        var msg = String.format("Do you want to cancel {0}?", orderProduct.name);
        var cancelStatusId = STATUS.ItemCancelledStatusId;
        if (confirm(msg)) {
            $http({
                method: 'POST',
                url: __env.apiUrl(String.format('orders/UpdateOrderProductStatus/{0}/{1}', orderProduct.orderProductId, cancelStatusId))
            })
            .then(function (response) {
                $state.reload();
            }), function (error) {
                alert('cannot cancel. kitchen already processed it.');
            };
        }
    };

    $scope.selectAddons = function (orderProduct) {

        cartFactory.setCurrentProduct(orderProduct);
        cartFactory.initAddons(orderProduct);

        $scope.$parent.isShowAddons = true;
        $scope.$parent.isShowProducts = false;
        $scope.$parent.isShowCart = false;
    };

    $scope.selectProduct = function () {
        $scope.$parent.isShowProducts = true;
        $scope.$parent.isShowAddons = false;
        $scope.$parent.isShowCart = false;
    };
}])
