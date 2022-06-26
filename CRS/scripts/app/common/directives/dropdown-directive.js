/*

Quick reminder

@:          literal
=:  2 way binding
&:  function binding

http://weblogs.asp.net/dwahlin/creating-custom-angularjs-directives-part-3-isolate-scope-and-function-parameters
http://stackoverflow.com/questions/29915223/angularjs-pass-ngmodel-from-wrapper-directive-to-wrapped-directive

Using ngOptions
http://www.undefinednull.com/2014/08/11/a-brief-walk-through-of-the-ng-options-in-angularjs/

Using premise to wait for async
http://stackoverflow.com/questions/18421830/how-to-wait-till-the-response-comes-from-the-http-request-in-angularjs

*/

//angular.module("helper.directives", ['service.lookupTable'])
angular.module("helper.directives", [])
.constant("TEMPLATE", {
                dropdown: ''// '../helper/dropdown.html'
})

.directive('sampleText', function () {
    return {
        restrict: "E",
        template: '<div>Some sample text here.</div>'
    };
})

/*
    Purpose: Display a dropdown select box using a lookup table and bind to a column
    Usage:   <helper-dropdown column="categoryId" lookup-table="category"></helper-dropdown>
*/

.directive('directive.Dropdown', ['TEMPLATE', 'lookupTableService', function (TEMPLATE, lookupTableService) {
                return {
                                restrict: "E",
                                scope: {
                                                lookupTable: '@',
                                                column: '='
                                },
                                require: 'column',
                                template: '<div>Some  text here. {{lookupTable}} {{message}}</div>',
                                //templateUrl: TEMPLATE.dropdown,
                                controller: function ($scope) {
                                                var dataPremise = lookupTableService.getItems($scope.lookupTable);
                                                dataPremise.then(function (result) {
                                                                $scope.items = result;
                                                });
                                },
                };
}])