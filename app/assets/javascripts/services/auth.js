PsiPlotApp.factory('Auth', ['$resource',
  function($resource) {

    return $resource('/api/session');

  }
]);
