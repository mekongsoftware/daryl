/*  Notes:
 
    table CRUD operation
 
    1. Rows retrieved are saved in $scope.allItems array, displayed with ng-repeat
    2. $scope.currentItem is accessed by using $index from ng-repeat
    3. $scope.listView set to true to display a list, false to display entry form (controlled by ng-show in main.html)
    4. Row CRUD are done using $resource factory
    5. Index is the internal id returned by REST query (index + 1)

    reference:
    https://www.safaribooksonline.com/blog/2013/05/16/angularjs-ngresource-tips-and-tricks/
 
*/


// CREATE new admin.table module (WITH [] injection, this is a CREATION of module, otherwise it's a retrieval)
angular.module("admin.table", [
    // required, but already inject in parent project
    //'ui.router'
    //, 'ngResource'
    //, 'ngMessages'
    //, 'helper.filters'
])


// *********
// services
// *********

.factory('tableFactory', ['$resource', 
    function ($resource) {
        return $resource(__env.apiBaseUrl + 'tables/:id', {}, {
            query: { method: 'GET', isArray: true },
            create: { method: 'POST' },
            retrieve: { method: 'GET' },
            update: { method: 'PUT' },
            delete: { method: 'DELETE' }
        })
    }
])

// ***********
// controllers
// ***********
.controller("tableAdminCtrl", ['$scope', 'tableFactory', 
    function ($scope, tableFactory) {
        $scope.getAllItems = function () {
            tableFactory.query(function (data) {
                $scope.allItems = data;
            });
        };

        $scope.edit = function (index) {
            $scope.setCurrentItem(index);
            $scope.listView = false;
        };

        $scope.cancel = function () {
            $scope.listView = true;
        };

        $scope.save = function () {
            if ($scope.currentItem.tableId == 0) {
                tableFactory.create($scope.currentItem
                    , function () { $scope.getAllItems(); }     // call back function to refresh page
                    );
            }
            else {
                tableFactory.update({ id: $scope.currentItem.tableId }, $scope.currentItem
                    , function () { $scope.getAllItems(); }      // call back function to refresh page
                    );
            }
            $scope.listView = true;
        };

        $scope.softDelete = function (flag) {
            $scope.currentItem.isActive = flag;
            $scope.save();
        };

        $scope.delete = function (index) {
            setCurrentItem(index);
            if (confirm("Delete " + $scope.currentItem.name + ". Are you sure?" + index)) {
                tableFactory.delete({ id: $scope.currentItem.tableId }
                    , function () { $scope.getAllItems(); }     // call back function to refresh page
                    );
            }
        };

        $scope.create = function () {
            $scope.setCurrentItem();
            $scope.listView = false;
        };

        // assign currentItem from allItem array, using index, no parameter will initialize to empty entry
        $scope.setCurrentItem = function (index) {
            if (typeof index !== 'undefined') {
                $scope.currentItem = $scope.allItems[index];
            }
            else {
                $scope.currentItem = {
                    tableId: 0,
                    name: '',
                    vname: ''
                };
            }
        };

        /*
        $scope.mocktables = [
            { "tableId": 1, "name": "sample string 1", "price": 1.0 },
            { "tableId": 1, "name": "sample string 2", "price": 2.0 }
        ];
        */

        // -----------------------
        // execution starts here
        // -----------------------

        $scope.listView = true;
        $scope.currentItem = {};
        $scope.getAllItems();
    }]);
