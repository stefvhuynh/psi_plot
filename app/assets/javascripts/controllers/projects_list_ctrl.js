PsiPlotApp.controller('ProjectsListCtrl', ['$scope',
  function($scope) {

    $scope.projects = [
      { title: "Example 1",
        content: "First example" },
      { title: "Example 2",
        content: "Second Example" }
    ];

  }
]);
