PsiPlotApp.controller('HomeCtrl', ['$scope', '$location', 'Auth',
  function($scope, $location, Auth) {

    $scope.auth = { email: '', password: '' };

    $scope.submitAuth = function() {
      Auth.save({ session: $scope.auth }, function(response) {
        console.log(response);
        $location.path('/projects');
      }, function(error) {
        console.log(error);
      });
    };

  }
]);
