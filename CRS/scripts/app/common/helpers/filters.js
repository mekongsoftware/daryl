angular.module("helper.filters", [])
.filter('is_active', function () {
    return function (value) {
        return value === false ? 'Inactive' : 'Active';
    };
})