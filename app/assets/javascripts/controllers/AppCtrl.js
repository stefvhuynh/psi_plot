PsiPlotApp.controller('AppCtrl', ['$scope', '$http', function($scope, $http) {
	
	// Partials
	$scope.partials = {
		header: "header.html"
	}
	
	// Authentication
	$scope.currentUser = (typeof currentUser != "undefined") ? currentUser : null
	$scope.loggedIn = $scope.currentUser ? true : false
	$scope.errorMsg = ""
	
	$scope.userCredentials = {
		email: "",
		password: ""
	}

	$scope.login = function() {
		$http.post('/api/session', { session: {
			email: $scope.userCredentials.email,
			password: $scope.userCredentials.password
			}
		}).
	  success(function(data, status, headers, config) {
			$scope.currentUser = data.email
			$scope.loggedIn = true
			$scope.errorMsg = ""
	    console.log("success!")
			$scope.render.login()
	  }).
	  error(function(data, status, headers, config) {
	    $scope.errorMsg = data.errors
			console.log("error!")
			$scope.render.error()
	  });
	}
	
	$scope.logout = function() {
		$http.delete('/api/session').
	  success(function(data, status, headers, config) {
			$scope.render.logout(function() {
				$scope.currentUser = null
				$scope.loggedIn = false
				$scope.errorMsg = ""
		    console.log("success!")
			})
	  }).
	  error(function(data, status, headers, config) {
	    $scope.errorMsg = data.errors
			console.log("error!")
			$scope.render.error()
	  });
	}
	
	// RENDER
	
	$scope.render = {
		checkLogin: function() {
			$scope.loggedIn ? $('.logged-in').show() : $('.logged-out').show()
		},
		login: function(callback) {
			$('.logged-out').fadeOut(function() {
				if (callback) { callback() }
				$('.logged-in').fadeIn()
			})
		},
		logout: function(callback) {
			$('.logged-in').fadeOut(function() {
				if (callback) { callback() }
				$('.logged-out').fadeIn()
			})
		},
		error: function() {
			$('.errors').fadeIn().delay(2000).fadeOut()
		}
	}
	
	// INITIALIZE

	
}]);
