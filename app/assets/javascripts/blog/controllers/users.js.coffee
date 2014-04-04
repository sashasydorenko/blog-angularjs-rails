usersControllers = angular.module 'usersControllers', []

# Sing In
usersControllers.controller 'SignInCtrl', ($rootScope, $scope, $location, flash, Auth) ->
  success = (data) ->
    $rootScope.is_logged = true
    $rootScope.is_admin = data.user.is_admin
    $location.path '/'
    flash.pop 'success', 'You logged!'

  error = (error) ->
    flash.pop 'error', error.data.errors
    $rootScope.is_logged = false
    $rootScope.is_admin = false

  $scope.signIn = -> Auth.sign_in(user: $scope.user).$promise.then success, error

# Sing Up
usersControllers.controller 'SignUpCtrl', ($rootScope, $scope, $location, flash, Auth) ->
  success = (data) ->
    $rootScope.is_logged = true
    $location.path '/'
    flash.pop 'success', 'You register!'

  error = (error) ->
    $rootScope.is_logged = false
    flash.pop 'error', input.replace(/_/g," ") + ' ' + error[0]  for input, error of error.data

  $scope.submitSignUp = -> Auth.sign_up(user: $scope.user).$promise.then success, error

# Sing Out
usersControllers.controller 'SignOutCtrl', ($rootScope, $scope, $location, flash, Auth) ->
  success = (data) ->
    $rootScope.is_logged = false
    $rootScope.is_admin = false
    $location.path '/'
    flash.pop 'success', 'You is logout!'
     
  error = (error) -> flash.pop 'error', data

  Auth.sign_out(user: $scope.user).$promise.then success, error
