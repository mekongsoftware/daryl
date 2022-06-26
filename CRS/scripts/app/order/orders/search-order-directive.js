angular.module("order")
.constant("PAGE_SIZE", 7)
.directive("searchOrder", ['PAGE_SIZE', function (PAGE_SIZE) {
    return {
        restrict: 'EA',
        templateUrl: '/Scripts/app/order/order/searchOrder.html',
        compile: function () {
            $('#fromDate, #toDate')
                .datepicker('setValue', new Date()); //$scope.formData.orderDateFrom);
            $('#fromDate, #toDate')
                // make sure from/to date are valid
                .on('changeDate', function (ev) {
                    var id = ev.target.id;
                    var fromDate = new Date($('#fromDate').val());
                    var toDate = new Date($('#toDate').val());
                    var isValid = false;
                    isValid = (id == 'fromDate')
                        ? ev.date.valueOf() <= toDate.valueOf()
                        : ev.date.valueOf() >= fromDate.valueOf()
                    if (!isValid) {
                        alert('From Date must be earlier than To Date');
                    }
                })
        },
        controller: function ($scope) {
            $scope.formData = {
                orderStatus: 'Unpaid',
                orderDateFrom: new Date(),
                orderDateTo: new Date(),
                customerName: 'John',
                technicianName: 'Lisa'
            };

            $scope.showResults = false;
            $scope.foundOrders = {};
            $scope.findOrders = function () {
                $scope.foundOrders =
                    [
                        { orderId: 1, orderNumber: '1', orderStatus: 'Unpaid', orderDate: '1/2/2016', customerName: 'John', technicianName: 'Lisa' },
                        { orderId: 2, orderNumber: '2', orderStatus: 'Unpaid', orderDate: '1/2/2016', customerName: 'Jack', technicianName: 'Linda' },
                        { orderId: 3, orderNumber: '3', orderStatus: 'Unpaid', orderDate: '1/2/2016', customerName: 'Jerry', technicianName: 'Michelle' },
                        { orderId: 4, orderNumber: '4', orderStatus: 'Unpaid', orderDate: '1/2/2016', customerName: 'Tom', technicianName: 'Tracy' },
                    ];
                $scope.showResults = true;
            }
        }
    }
}])

