PsiPlotApp.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {

  $locationProvider.html5Mode(true);

/*   $routeProvider.when('/', { */
      // redirectTo: function(current, path, search) {
        // if(search.goto) {
          // return '/' + search.goto;
        // } else {
          // return '/home';
        // }
      // }
    // }).when('/home', {
      // templateUrl: 'home.html',
      // controller: 'HomeCtrl'
    // }).when('/index', {
      // templateUrl: 'collections/index.html',
      // controller: 'CollectionIndexCtrl'
    // }).otherwise({
      // redirectTo: '/home'
    /* }); */

    $routeProvider
      .when('/', {
        templateUrl: 'index.html',
        controller: 'HomeCtrl'
    })
      .when('/index', {
        templateUrl: 'collections/index.html',
        controller: 'CollectionIndexCtrl'
    });

}]);
