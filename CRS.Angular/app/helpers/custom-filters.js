angular.module("custom-filters", [])

.filter('is_active', function () {
    return function (value) {
        return value === false ? 'Inactive' : 'Active';
    };
})

// display name from lookup array 
// usage: {{product.productId | lookupName: lookup.products : 'productId' }}
.filter('lookupName', function ($filter) {
    return function (id, lookup, idName) {
        var value = '';
        if (lookup != undefined) {
            var obj = lookup.find(idName, id);
            if (obj != null) {
                value = obj.name;
            }
        }
        return value;
    }
})

.filter('lookupDesc', function ($filter) {
    return function (id, lookup, idName) {
        var value = '';
        if (lookup != undefined) {
            var obj = lookup.find(idName, id);
            if (obj != null) {
                value = obj.description;
            }
        }
        return value;
    }
})

// create a list of addon description
.filter('productModifiers', function ($filter) {
    return function (product, lookup, option) {
        if (lookup == undefined) return '';
        
        var ret = '';
        for (var i = 0; i < product.orderProductAddons.length; i++) {
            var addon = product.orderProductAddons[i];
            if ((option == 'freeOnly') && (addon.price > 0)) {
                continue;
            }
            ret += ret=='' ? '' : ', ';
            ret += $filter('lookupName')(addon.addonId, lookup.addons, 'addonId')
        }
        return ret;
    }
})

// translate, expect parameters: $rootScope.translations
.filter('translate', ['$rootScope', function ($rootScope, $filter) {
    return function (key) {
        var obj = $rootScope.translations.find('key', key.toLowerCase());
        return obj != undefined ? obj.value : key;
    }
}])

.filter('ellapsedMinutes', function ($filter) {
    return function (time) {
        if (time == null) {
            return '';
        }
        var now = new Date;
        var from = new Date(time);  // time is UTC
        var ms = now - from;
        var minutes = Math.floor(ms / 60000);
        return minutes;
    }
})

// break array in "chunk" for displaying multiple columns
.filter('chunk', function ($filter) {
    return function (arr, size) {
        if (arr == undefined) return null;
        var newArr = [];
        for (var i=0; i<arr.length; i+=size) {
            newArr.push(arr.slice(i, i+size));
        }
        return newArr;
    }
})