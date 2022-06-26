/*
Name:       navigationDir
Purpose:    Directive to create Bootstrap navbar
Author:     Daryl Khuong
Usage:      <div navigation-dir current-state='test' user-access-level='0'>
Dependent:  'AppSettings' module constant that has LeftMenu and RightMenu
Attributes:
currentState:       state name as used in ui.router, use to highlight current state
userAccessLevel:    current user access level, 
                    items with higher value in MenuItems will not be rendered
                    items with accessLevel -1 will be rendered only if userAccessLevel is 0 (for login/signup pages)
userName:   Use to display on navbar
 
Sample Menu:
 
*/


angular.module("navigationDir", [])
.directive("navigationDir", ['$filter', '$compile', 'AppSettings',
    function ($filter, $compile, appSettings) {
    return {
        restrict: 'EA',
        scope: {
            currentState: '@',
            userAccessLevel: '@',
            userName: '@',
            currentLanguage: '@'
        },
        link: function ($scope, $element, $attrs) {
            // need to watch user name and access level so the navbar can be updated
            $scope.$watch('[userName, userAccessLevel, currentState, currentLanguage]', function () {
                var rawHtml = createNavBar(appSettings, $scope.currentState, $scope.userName, $scope.userAccessLevel);
                var html = $compile(rawHtml)($scope);
                $element.empty();       // using $watch, make sure no duplicate
                $element.append(html);
            })
        }
    };

    var _currentState, _userAccessLevel, _userName, _tags;      // use as global variable

    function createNavBar(appSettings, currentState, userName, userAccessLevel) {
        _currentState = currentState;        
        _userName = userName;
        _userAccessLevel = userAccessLevel;
        var liClass
        var navLiLeft = '';
        var navLiRight = '';

        // home item
        //liClass = appSettings.HomeLink.state != currentState ? '' : 'class="active"';
        //navLiLeft = String.format('<li {0}><a href="{1}">{2}</a>', liClass, appSettings.HomeLink.state, appSettings.HomeLink.name);
        
        navLiLeft += itemHtml(appSettings.LeftMenu);
        navLiRight += itemHtml(appSettings.RightMenu);
        var navUlLeft = String.format('<ul class="nav nav-pills">{0}</ul>', navLiLeft);
        var navUlRight = String.format('<ul class="nav nav-pills pull-right">{0}</ul>', navLiRight);
        var nav = '<div class="row"><div class="col-sm-7">{0}</div><div class="col-sm-5">{1}</div></div>'
        return String.format(nav, navUlLeft, navUlRight);
    };

    function itemHtml(menuItems) {
        var liClass;
        var navLi = '';
        for (var i = 0; i < menuItems.length; i++) {
            var item = menuItems[i];
            // state may contain parameters, make sure it's stripped out
            liClass = item.state.split('(')[0] != _currentState ? '' : 'class="active"';
            if (_userAccessLevel > 0 && item.accessLevel == -1 ||
                    item.accessLevel > _userAccessLevel && item.accessLevel != -1) {
                continue;
            }
            navLi += String.format('<li {0}><a ui-sref="{1}">{2}</a>', liClass, item.state, item.name);
        }
        return navLi;
    }
}])