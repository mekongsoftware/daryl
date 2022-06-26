// simulate .net string.Format
// example: string.format("/Student/GetStudentById/{0}/collegeId/{1}", studentId, collegeId)
String.format = function () {
    // The string containing the format items (e.g. "{0}")
    // will and always has to be the first argument.
    var theString = arguments[0];

    // start with the second argument (i = 1)
    for (var i = 1; i < arguments.length; i++) {
        // "gm" = RegEx options for Global search (more than one instance)
        // and for Multiline search
        var regEx = new RegExp("\\{" + (i - 1) + "\\}", "gm");
        theString = theString.replace(regEx, arguments[i]);
    }
    return theString;
};

// search array using property
// example: arr = [{ name: 'john', age: 20 }, { name: 'jack', age: 22 }]
// var johnObj = arr.find('name', 'jack');
Array.prototype.find = function (property, value) {
    var i = -1;
    try {
        var i = this.map(function (e) { return eval('e.' + property); }).indexOf(value);
    }
    catch (error) {
        console.log(error);
    }
    return i < 0 ? null : this[i];
};

Date.prototype.getJulian = function () {
    var julian = Math.floor((this) / 86400000 - 2440587.5);
    return julian;
}