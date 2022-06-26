angular.module("helper.directives", [])
// to use currency in ng-model
// <input type="text" ng-model="amount" currency>
.directive('currency', function () {
    console.log('currency called...');
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (el, $scope, attrs, ngModel) {
            ngModel.$formatters.push(function (val) {
                return '$' + val
            });
            ngModel.$parser.push(function (val) {
                return val.replace(/^\$/, '')
            });
        }
    };
})