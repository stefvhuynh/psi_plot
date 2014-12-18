var PsiPlotApp = angular.module('PsiPlotApp', [
  'ngRoute',
  'ngResource',
  'templates'
]);

PsiPlotApp.config(['$routeProvider',
  function($routeProvider) {

    $routeProvider
      .when('/', {
        templateUrl: 'index.html',
        controller: 'HomeCtrl'
      })
      .when('/projects', {
        templateUrl: 'projects/list.html',
        controller: 'ProjectsListCtrl'
      });

  }
]);
