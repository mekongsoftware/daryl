angular.module("order")
.constant("productListActiveClass", "btn-primary")
.constant("productListPageCount", 8)
.controller("productListCtrl", ['$rootScope', '$scope', '$filter', 'productListActiveClass', 'productListPageCount', 'cartFactory',
function ($rootScope, $scope, $filter, activeClass, pageCount, cartFactory) {

    var defaultCategoryCode = 'PHO';          // should be in rootscope

    var selectedCategory = null;

    $scope.cartMessage = function () {
        return String.format('{0} items',
            cartFactory.data.orderProducts.length);
    };
    $scope.addedMessage = function () {
        return $scope.addedProduct.name
            ? $scope.addedProduct.name + ' added'
            : '';
    };

    $scope.selectedPage = 1;
    $scope.pageSize = pageCount;
    $scope.addedProduct = {};

    $scope.productRows = [];
    $scope.selectCategory = function (newCategory) {
        selectedCategory = newCategory;
        $scope.selectedPage = 1;
        $scope.addedProduct = {};
        $scope.productRows = $filter('chunk')($rootScope.lookup.products.filter(function (el) {
            return newCategory==undefined || el.categoryId == newCategory.categoryId;
        }), 4);
    }

    $scope.selectPage = function (newPage) {
        $scope.selectedPage = newPage;
    }

    $scope.categoryFilterFn = function (product) {
        return selectedCategory == null || product.categoryId == selectedCategory.categoryId;
    }

    $scope.getCategoryClass = function (category) {
        return selectedCategory == category ? activeClass : "";
    }

    $scope.getPageClass = function (page) {
        return $scope.selectedPage == page ? activeClass : "";
    }

    $scope.addProductToCart = function (product) {
        cartFactory.addProduct(product);
        $scope.addedProduct = product;
        // close or keep product selection?
        //$scope.closeProduct();
    }

    $scope.removeProductFromCart = function (id) {
        cartFactory.removeProduct(id);
    }

    $scope.closeProduct = function () {
        $scope.$parent.isShowCart = true;
        $scope.$parent.isShowProducts = false;
    };

    $scope.$watch('lookup.categories', function (data) {
        if (data) {
            $scope.selectCategory($rootScope.lookup.categories.find('code', defaultCategoryCode));
        }
    });
}])
