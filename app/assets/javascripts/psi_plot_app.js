var PsiPlotApp = angular.module('PsiPlotApp', [
  'ngRoute',
  'templates'
]);

PsiPlotApp.config(['$routeProvider',
  function($routeProvider) {

    $routeProvider
      .when('/', {
        templateUrl: 'index.html',
        controller: 'HomeCtrl'
      })
      .when('/index', {
        templateUrl: 'collections/index.html',
        controller: 'CollectionIndexCtrl'
      });

  }
]);
