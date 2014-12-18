PsiPlotApp.controller('HomeCtrl', ['$scope', 'Auth',
  function($scope, Auth) {

    $scope.auth = { email: '', password: '' };

    $scope.submitAuth = function() {
      Auth.save({ session: $scope.auth }, function(response) {
        console.log(response);
      }, function(error) {
        console.log(error);
      });
    };

  }
]);
