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
            $scope.$watch('[userName, userAccessLevel, currentLanguage]', function () {
                var rawHtml = createNavBar(appSettings, $scope.currentState, $scope.userName, $scope.userAccessLevel);
                var html = $compile(rawHtml)($scope);
                $element.empty();       // using $watch, make sure no duplicate
                $element.append(html);
            })
        }
    };

    var _currentState, _userAccessLevel, _userName, _tags;      // use as global variable

    // create bootstrap navbar html
    function createNavBar(appSettings, currentState, userName, userAccessLevel) {
        _currentState = currentState;
        _userName = userName;
        _userAccessLevel = userAccessLevel;
        _tags = createElements();
        var html;
        html = String.format(_tags.navBegin, appSettings.HomeLink.state, appSettings.HomeLink.name);        // Home link
        html += createLeftMenu(appSettings);    // left menu
        html += createRightMenu(appSettings);   // right menu
        html += _tags.navEnd;
        return html;
    }

    // create left menu items
    function createLeftMenu(appSettings) {
        var menuItems = appSettings.LeftMenu;
        var html = _tags.menuLeftBegin;
        for (var i = 0; i < menuItems.length; i++) {
            var item = menuItems[i];
            if (_userAccessLevel > 0 && item.accessLevel == -1 ||
                    item.accessLevel > _userAccessLevel && item.accessLevel != -1) {
                continue;
            }
            html += (typeof item.subMenu === 'undefined')
                ? createLink(item)
                : createDropdown(item, _tags, _currentState, _userAccessLevel);
        }
        html += _tags.menuEnd;
        return html;
    }

    // create right menu items
    function createRightMenu(appSettings) {
        var html = '';
        var menuItems = appSettings.RightMenu;
        if (_userAccessLevel > 0) {
            html = String.format(_tags.liNoLink, _userName);
        }
        for (var i = 0; i < menuItems.length; i++) {
            var item = menuItems[i];
            if (_userAccessLevel > 0 && item.accessLevel == -1 ||
                    item.accessLevel > _userAccessLevel && item.accessLevel != -1) {
                continue;
            }
            html += (typeof item.subMenu === 'undefined')
                ? createLink(item)
                : createDropdown(item, _tags, _currentState, _userAccessLevel);
        }
        return _tags.menuRightBegin + html + _tags.menuEnd;
    }

    // create a single link
    function createLink(item) {
        var name = item.name; // $filter('translate')(item.name);
        return (typeof item.onClick === 'undefined')
        ? String.format(_tags.li, item.state, name)
        : String.format(_tags.liOnClick, item.state, name, item.onClick);
    }

    // create dropdown menu 
    function createDropdown(menuItem) {
        var menuName = menu.name; // $filter('translate')(menu.name);
        var name = menu.name; // $filter('translate')(menu.name);
        var html = String.format(_tags.dropdownBegin, menuItem.state, menuName);
        var subMenu = menuItem.subMenu;
        for (var i = 0; i < subMenu.length; i++) {
            var item = subMenu[i];
            // skip item with accessLevel -1 if user already logged in (login, signup...)
            if (_userAccessLevel > 0 && item.accessLevel == -1 ||
                 item.accessLevel > _userAccessLevel && item.accessLevel != -1) {
                continue;
            }
            html += (item.state == '-') ? _tags.liSeparator : String.format(_tags.li, item.state, name);
        }
        html += _tags.dropdownEnd;
        return html;
    }

    // create nav html _tags, will inject actual value into {0}, {1}...
    // html are taken from bootstrap example
    function createElements() {
        return {
            navBegin:
            '<nav class="navbar navbar-default">                                                                                                                  ' +
            '  <div class="container-fluid">                                                                                                                      ' +
            '    <!-- Brand and toggle get grouped for better mobile display -->                                                                                  ' +
            '    <div class="navbar-header">                                                                                                                      ' +
            '      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">' +
            '        <span class="sr-only">Toggle navigation</span>                                                                                               ' +
            '        <span class="icon-bar"></span>                                                                                                               ' +
            '        <span class="icon-bar"></span>                                                                                                               ' +
            '        <span class="icon-bar"></span>                                                                                                               ' +
            '      </button>                                                                                                                                      ' +
            '      <a class="navbar-brand" ui-sref="{0}">{1}</a>                                                                                                     ' +
            '    </div>                                                                                                                                           ' +
            '                                                                                                                                                     ' +
            '    <!-- Collect the nav links, forms, and other content for toggling -->                                                                            ' +
            '    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">                                                                         ',
            navEnd:
            '    </div><!-- /.navbar-collapse -->                                                                                                                 ' +
            '  </div><!-- /.container-fluid -->                                                                                                                   ' +
            '</nav>                                                                                                                                               ',

            menuLeftBegin:
            '      <ul class="nav navbar-nav">                                                                                                                    ',
            menuRightBegin:
            '      <ul class="nav navbar-nav navbar-right">                                                                                                       ',
            menuEnd:
            '      </ul>                                                                                                                                          ',

            li:
            '<li><a ui-sref="{0}">{1}</a></li>',
            liOnClick:
            '<li><a ui-sref="{0}" onclick="{2}">{1}</a></li>',
            liActive:
            '<li class="active"><a ui-sref="{0}">{1}<span class="sr-only">(current)</span></a></li>',
            liSeparator:
            '<li role="separator" class="divider"></li>',
            //dropdownBegin:
            //'<li class="dropdown">                                                                                                                                            ' +
            //'   <a ui-sref="{0}" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{1}<span class="caret"></span></a>      ' +
            //'   <ul class="dropdown-menu">                                                                                                                                    ',
            dropdownBegin:
            '<li class="dropdown">                                                                                                                                            ' +
            '   <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{1}<span class="caret"></span></a>      ' +
            '   <ul class="dropdown-menu">                                                                                                                                    ',
            dropdownEnd:
            '   </ul>                                                                                                                                                         ' +
            '</li>                                                                                                                                                            ',
            liNoLink:
            '<li><a>{0}</a><li>'
        }
    }
}])