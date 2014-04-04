config = angular.module 'config', []

config.config ($locationProvider, $httpProvider) ->
  $locationProvider.html5Mode true
  $httpProvider.responseInterceptors.push 'httpInterceptor'

config.factory 'httpInterceptor', ($q, $window, $location) ->
  (promise) ->
    promise.then(
      (response) ->
        response
      (response) ->
        $location.path '/login' if response.status is 401
        $q.reject response
    )

config.run ($rootScope, $location) ->
  $rootScope.$on "$routeChangeStart", (event, current, prev) ->
    if current.access_admin && !$rootScope.is_admin
      if !$rootScope.is_logged then $location.path '/login' else $location.path '/'
      event.preventDefault()
