angular.module("order")
.constant("addonListActiveClass", "btn-primary")
.constant("addonListPageCount", 15)
.controller("addonListCtrl", ['$rootScope', '$scope', '$filter', 'addonListActiveClass', 'addonListPageCount', 'cartFactory',
function ($rootScope, $scope, $filter, activeClass, pageCount, cartFactory) {
    var defaultCategoryId = 6;          // should be in rootscope
    var selectedCategory = null;

    $scope.orderProductId = cartFactory.orderProductId;

    $scope.selectedPage = 1;
    $scope.pageSize = pageCount;
    //$scope.addons = [];

    $scope.selectCategory = function (newCategory) {
        selectedCategory = newCategory;
        $scope.selectedPage = 1;
    }

    $scope.selectPage = function (newPage) {
        $scope.selectedPage = newPage;
    }

    $scope.categoryFilterFn = function (addon) {
        return selectedCategory == null || addon.categoryId == selectedCategory.categoryId;
    }

    $scope.getCategoryClass = function (category) {
        return selectedCategory == category ? activeClass : "";
    }

    $scope.getPageClass = function (page) {
        return $scope.selectedPage == page ? activeClass : "";
    }

    $scope.addAddonToCart = function (addon, orderProductId) {
        cartFactory.addAddon(product, orderProductId);
    }

    $scope.removeAddonFromCart = function (id, orderProductId) {
        alert(id);
        cartFactory.removeAddon(id, orderProductId);
    }

    $scope.$watch(function () {
        return cartFactory.getCurrentProduct();
    }, function (newValue) {
        // make sure categories loaded
        if ($rootScope.lookup.categories) {
            $scope.selectCategory($rootScope.lookup.categories.find('categoryId', newValue.categoryId));
        }
    });
    $scope.selectedItems = [];

    // watch the list for changes 
    // http://output.jsbin.com/imaquc/1/
    $scope.$watch('lookup.addons|filter:{selected:true}', function (items) {
        $scope.selectedItems = items;
    }, true);

    $scope.saveAddons = function () {
        var selectedAddons = $rootScope.lookup.addons.filter(function (e) { return e.selected; });
        cartFactory.saveAddon(selectedAddons);
        $scope.$parent.isShowCart = true;
        $scope.$parent.isShowAddons = false;
    }
}])