angular.module("order")
.constant("productListActiveClass", "btn-primary")
.constant("productListPageCount", 7)
.controller("productListCtrl", function (
        $scope, $filter, productListActiveClass, productListPageCount, cart) {

    var selectedCategory = null;

    $scope.selectedPage = 1;
    $scope.pageSize = productListPageCount;

    $scope.selectCategory = function (newCategory) {
        selectedCategory = newCategory;
        $scope.selectedPage = 1;
    }

    $scope.selectPage = function (newPage) {
        $scope.selectedPage = newPage;
    }

    $scope.categoryFilterFn = function (product) {
        return selectedCategory == null ||
            product.categoryId == selectedCategory.categoryId;
    }

    $scope.getCategoryClass = function (category) {
        return selectedCategory == category ? productListActiveClass : "";
    }

    $scope.getPageClass = function (page) {
        return $scope.selectedPage == page ? productListActiveClass : "";
    }

    $scope.addProductToCart = function (product) {
        cart.addProduct(product.productId, product.name, product.price);
    }
});