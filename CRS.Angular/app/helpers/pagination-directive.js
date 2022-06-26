/*
compile: function(el, attr, transclude) {}
link: link($scope, $element, attrs, ctrl){}
controller: function(scope, el, attr, transcludeFn)
template: function(el, attrs)
*/


angular.module("dirPagination", [])
.directive("pagination", function ($compile) {
    var createTemplate = function (pageNo, pageSize, itemCount, maxLinks) {
        var pageCount = Math.ceil(itemCount / pageSize);         // total pages
        var beginPage = pageNo - Math.floor(maxLinks / 2);       // first page to show, try to center current page
        var showFirstLast = pageCount > maxLinks;                // whether to show goto first/last page link

        // calculate to show first page to center current page
        if (pageCount - beginPage < maxLinks) {
            beginPage = pageCount - maxLinks + 1;
        }
        if (beginPage < 1) {
            beginPage = 1;
        }
        // create pagination html using bootstrap
        var li = '<li class="{0}"><a href="" ng-click="goToPage({1})">{2}</a></li>'
        var html = '<ul class="pagination">';
        html += showFirstLast ? String.format(li, '', 1, '&laquo;') : '';
        for (i = beginPage, j = 0; i <= pageCount && j < maxLinks; i++, j++) {
            html += String.format(li, (i == pageNo) ? 'active' : '', i, i)
        }
        html += showFirstLast ? String.format(li, '', pageCount, '&raquo;') : ''
        html += '</ul>';
        return html;
    }

    return {
        scope: {
            currentPage: '=',
            pageSize: '=',
            rowCount: '=',
            goToPageFn: '&'
        },
        template: 'paging...',
        link: function ($scope, $element, $attrs) {
            // need to watch this variable so page can be updated
            $scope.$watch('[currentPage, rowCount]', function () {
                $scope.goToPage = function (pageNo) {
                    $scope.goToPageFn({ pageNo: pageNo });
                };
                if (typeof $scope.currentPage === 'undefined' || $scope.pageSize === 'undefined'
                    || $scope.rowCount === 'undefined' || $attrs.maxLinks === 'undefined') {
                    $element.append('currentPage, pageSize, rowCount and goToPage() are required for pagination.');
                    return;
                }
                var maxLinks = $attrs.maxLinks === undefined ? 5 : $attrs.maxLinks;   // number of links to display
                var rawHtml = createTemplate($scope.currentPage, $scope.pageSize, $scope.rowCount, maxLinks);
                // using template won't work, need to compile and using append
                var pagination = $compile(rawHtml)($scope);
                $element.empty();       // make sure no duplicate
                $element.append(pagination);
            })
        }
    };
})