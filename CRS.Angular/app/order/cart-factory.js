angular.module("order")
.factory('cartFactory', ['$rootScope', 'STATUS', function ($rootScope, STATUS) {
    var createId = function (cartData) {
        return cartData.length == 0
            ? 1
            : Math.max.apply(Math, cartData.map(function (o) { return o.id; })) + 1;
    }
    var currentProduct = {};
    return {
        data: {
            orderProducts: [],
            currentProduct: {}        // current
        },
        getTotalAmount: function() {
            var total = 0;
            for (var i = 0; i < this.data.orderProducts.length; i++) {
                total += (this.data.orderProducts[i].price * this.data.orderProducts[i].quantity);
                for (var j = 0; j < this.data.orderProducts[i].orderProductAddons.length; j++) {
                    total += this.data.orderProducts[i].orderProductAddons[j].price * this.data.orderProducts[i].quantity;
                }
            }
            return total;
        },
        clearCartContent: function () {
            this.data.orderProducts = [];
        },
        setCartContent: function (orderProducts) {
            if ($rootScope.lookup.products == undefined) return;
            for (var i = 0; i < orderProducts.length; i++) {
                orderProducts[i].isChangeAllowed = orderProducts[i].statusId == STATUS.ItemPreOrderStatusId;
                orderProducts[i].isCancellable = orderProducts[i].statusId == STATUS.ItemOrderConfirmedStatusId;
                orderProducts[i].id = i + 1;
                orderProducts[i].name = $rootScope.lookup.products.find('productId', orderProducts[i].productId).name;
                orderProducts[i].categoryId = $rootScope.lookup.products.find('productId', orderProducts[i].productId).categoryId
                for (var j = 0; j < orderProducts[i].orderProductAddons.length; j++) {
                    orderProducts[i].orderProductAddons[j].name =
                        $rootScope.lookup.addons.find('addonId', orderProducts[i].orderProductAddons[j].addonId).name;
                }
            }
            this.data.orderProducts = orderProducts;
        },
        addProduct: function (product) {
            var id = createId(this.data.orderProducts);
            this.data.orderProducts.push({
                id: id,
                quantity: 1,
                isChangeAllowed: true,
                isCancellable: false,
                productId: product.productId,
                price: product.price,
                isPriceChangeable: product.isPriceChangeable,
                name: product.name,
                categoryId: product.categoryId,
                orderProductAddons: [],
            });
        },
        removeProduct: function (id) {
            for (var i = 0; i < this.data.orderProducts.length; i++) {
                if (this.data.orderProducts[i].id == id) {
                    this.data.orderProducts.splice(i, 1);
                    break;
                }
            }
        },
        setCurrentProduct: function (item) {
            currentProduct = item;
        },
        getCurrentProduct: function () {
            return currentProduct;
        },
        saveAddon: function (addons) {
            currentProduct.orderProductAddons = addons;
        },
        initAddons: function (orderProduct) {
            this.data.currentProduct = orderProduct;
            // clear all addon selections
            for (var i = 0; i < $rootScope.lookup.addons.length; i++) {
                $rootScope.lookup.addons[i].selected = false;
            }
            // restore existing selections
            for (var i = 0; i < orderProduct.orderProductAddons.length; i++) {
                var addonIndex = $rootScope.lookup.addons.map(function (e) { return e.addonId; })
                            .indexOf(orderProduct.orderProductAddons[i].addonId);
                if (addonIndex > 0) {
                    $rootScope.lookup.addons[addonIndex].selected = true;
                }
            }
        },
    }
}])
