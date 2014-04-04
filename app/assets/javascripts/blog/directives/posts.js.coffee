postsDirectives = angular.module 'postsDirectives', []
 
postsDirectives.directive 'formPost', ->
  restrict: 'E'
  replace: true
  templateUrl: '/assets/posts/form.html'
