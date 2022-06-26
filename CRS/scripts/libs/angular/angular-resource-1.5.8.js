﻿/*
 AngularJS v1.5.8
 (c) 2010-2016 Google, Inc. http://angularjs.org
 License: MIT
*/
(function (P, d) {
    'use strict'; function G(t, g) { g = g || {}; d.forEach(g, function (d, q) { delete g[q] }); for (var q in t) !t.hasOwnProperty(q) || "$" === q.charAt(0) && "$" === q.charAt(1) || (g[q] = t[q]); return g } var z = d.$$minErr("$resource"), M = /^(\.[a-zA-Z_$@][0-9a-zA-Z_$@]*)+$/; d.module("ngResource", ["ng"]).provider("$resource", function () {
        var t = /^https?:\/\/[^\/]*/, g = this; this.defaults = {
            stripTrailingSlashes: !0, cancellable: !1, actions: {
                get: { method: "GET" }, save: { method: "POST" }, query: { method: "GET", isArray: !0 }, remove: { method: "DELETE" },
                "delete": { method: "DELETE" }
            }
        }; this.$get = ["$http", "$log", "$q", "$timeout", function (q, L, H, I) {
            function A(d, h) { return encodeURIComponent(d).replace(/%40/gi, "@").replace(/%3A/gi, ":").replace(/%24/g, "$").replace(/%2C/gi, ",").replace(/%20/g, h ? "%20" : "+") } function B(d, h) { this.template = d; this.defaults = v({}, g.defaults, h); this.urlParams = {} } function J(e, h, n, k) {
                function b(a, c) {
                    var b = {}; c = v({}, h, c); u(c, function (c, h) {
                        x(c) && (c = c(a)); var f; if (c && c.charAt && "@" == c.charAt(0)) {
                            f = a; var l = c.substr(1); if (null == l || "" === l || "hasOwnProperty" ===
                            l || !M.test("." + l)) throw z("badmember", l); for (var l = l.split("."), m = 0, k = l.length; m < k && d.isDefined(f) ; m++) { var r = l[m]; f = null !== f ? f[r] : void 0 }
                        } else f = c; b[h] = f
                    }); return b
                } function N(a) { return a.resource } function m(a) { G(a || {}, this) } var t = new B(e, k); n = v({}, g.defaults.actions, n); m.prototype.toJSON = function () { var a = v({}, this); delete a.$promise; delete a.$resolved; return a }; u(n, function (a, c) {
                    var h = /^(POST|PUT|PATCH)$/i.test(a.method), e = a.timeout, E = d.isDefined(a.cancellable) ? a.cancellable : k && d.isDefined(k.cancellable) ?
                    k.cancellable : g.defaults.cancellable; e && !d.isNumber(e) && (L.debug("ngResource:\n  Only numeric values are allowed as `timeout`.\n  Promises are not supported in $resource, because the same value would be used for multiple requests. If you are looking for a way to cancel requests, you should use the `cancellable` option."), delete a.timeout, e = null); m[c] = function (f, l, k, g) {
                        var r = {}, n, w, C; switch (arguments.length) {
                            case 4: C = g, w = k; case 3: case 2: if (x(l)) { if (x(f)) { w = f; C = l; break } w = l; C = k } else { r = f; n = l; w = k; break } case 1: x(f) ?
                            w = f : h ? n = f : r = f; break; case 0: break; default: throw z("badargs", arguments.length);
                        } var D = this instanceof m, p = D ? n : a.isArray ? [] : new m(n), s = {}, A = a.interceptor && a.interceptor.response || N, B = a.interceptor && a.interceptor.responseError || void 0, y, F; u(a, function (a, c) { switch (c) { default: s[c] = O(a); case "params": case "isArray": case "interceptor": case "cancellable": } }); !D && E && (y = H.defer(), s.timeout = y.promise, e && (F = I(y.resolve, e))); h && (s.data = n); t.setUrlParams(s, v({}, b(n, a.params || {}), r), a.url); r = q(s).then(function (f) {
                            var b =
                            f.data; if (b) { if (d.isArray(b) !== !!a.isArray) throw z("badcfg", c, a.isArray ? "array" : "object", d.isArray(b) ? "array" : "object", s.method, s.url); if (a.isArray) p.length = 0, u(b, function (a) { "object" === typeof a ? p.push(new m(a)) : p.push(a) }); else { var l = p.$promise; G(b, p); p.$promise = l } } f.resource = p; return f
                        }, function (a) { (C || K)(a); return H.reject(a) }); r["finally"](function () { p.$resolved = !0; !D && E && (p.$cancelRequest = d.noop, I.cancel(F), y = F = s.timeout = null) }); r = r.then(function (a) { var c = A(a); (w || K)(c, a.headers); return c }, B);
                        return D ? r : (p.$promise = r, p.$resolved = !1, E && (p.$cancelRequest = y.resolve), p)
                    }; m.prototype["$" + c] = function (a, b, d) { x(a) && (d = b, b = a, a = {}); a = m[c].call(this, a, this, b, d); return a.$promise || a }
                }); m.bind = function (a) { return J(e, v({}, h, a), n) }; return m
            } var K = d.noop, u = d.forEach, v = d.extend, O = d.copy, x = d.isFunction; B.prototype = {
                setUrlParams: function (e, h, n) {
                    var k = this, b = n || k.template, g, m, q = "", a = k.urlParams = {}; u(b.split(/\W/), function (c) {
                        if ("hasOwnProperty" === c) throw z("badname"); !/^\d+$/.test(c) && c && (new RegExp("(^|[^\\\\]):" +
                        c + "(\\W|$)")).test(b) && (a[c] = { isQueryParamValue: (new RegExp("\\?.*=:" + c + "(?:\\W|$)")).test(b) })
                    }); b = b.replace(/\\:/g, ":"); b = b.replace(t, function (a) { q = a; return "" }); h = h || {}; u(k.urlParams, function (a, e) {
                        g = h.hasOwnProperty(e) ? h[e] : k.defaults[e]; d.isDefined(g) && null !== g ? (m = a.isQueryParamValue ? A(g, !0) : A(g, !0).replace(/%26/gi, "&").replace(/%3D/gi, "=").replace(/%2B/gi, "+"), b = b.replace(new RegExp(":" + e + "(\\W|$)", "g"), function (a, c) { return m + c })) : b = b.replace(new RegExp("(/?):" + e + "(\\W|$)", "g"), function (a, c, b) {
                            return "/" ==
                            b.charAt(0) ? b : c + b
                        })
                    }); k.defaults.stripTrailingSlashes && (b = b.replace(/\/+$/, "") || "/"); b = b.replace(/\/\.(?=\w+($|\?))/, "."); e.url = q + b.replace(/\/\\\./, "/."); u(h, function (a, b) { k.urlParams[b] || (e.params = e.params || {}, e.params[b] = a) })
                }
            }; return J
        }]
    })
})(window, window.angular);
//# sourceMappingURL=angular-resource.min.js.map