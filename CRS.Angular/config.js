// debug environment

(function (window) {
    window.__env = window.__env || {};
    //window.__env.baseUrl = 'http://guavasystem.azurewebsites.net';          // local dev, azure web api
    window.__env.baseUrl = 'http://localhost:49818';          // local, NUC
    //window.__env.baseUrl = 'http://localhost:49808';          // local, laptop
    //window.__env.baseUrl = 'http://localhost';                // local IIS

    //window.__env.baseUrl = '';                                // production
    window.__env.apiBaseUrl = window.__env.baseUrl + '/api/';
    window.__env.apiHelpUrl = window.__env.baseUrl + '/help';
    window.__env.tokenUrl = window.__env.baseUrl + '/token';

    // return __env.apiBaseUrl + relativeUrl
    window.__env.apiUrl = function (relativeUrl) {
        return window.__env.apiBaseUrl + relativeUrl;
    }
}(this));