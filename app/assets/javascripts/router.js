PsiPlotApp.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {

  $locationProvider.html5Mode(true)

  $routeProvider.
    when('/', {
      redirectTo: function(current, path, search) {
        if(search.goto) {
          return "/" + search.goto
        } else {
          return '/home'
        }
      }
    }).
    when('/home', {
      templateUrl: 'home.html',
      controller: 'HomeCtrl'
    }).
    when('/projects', {
      templateUrl: 'projects/index.html',
      controller: 'ProjectIndexCtrl'
    }).
    otherwise({
      redirectTo: '/home'
    });
}]);
