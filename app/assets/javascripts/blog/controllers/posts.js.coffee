postsControllers = angular.module 'postsControllers', ['ngSanitize']

# Posts list
postsControllers.controller 'PostsListCtrl', ($rootScope, $scope, flash, Post) ->
  $scope.posts = Post.all()

  $scope.deletePost = (id, idx) ->
    if confirm 'Delete ' + $scope.posts[idx].title + '?'
      Post.delete(id).$promise.then(
          (data) ->
            flash.pop 'success', 'Post is deleted.'
            $scope.posts.splice idx, 1
          (error) -> flash.pop 'error', error.data.errors
        )

# Post detail
postsControllers.controller 'PostsDetailCtrl', ($scope, $routeParams, $location, flash, Post) ->
  $scope.post = Post.index $routeParams.postId

  success = (data) ->
    flash.pop 'success', 'Post is deleted.'
    $location.path '/posts'

  error = (error) -> flash.pop 'error', error.data.errors

  $scope.deletePost = (id) -> Post.delete(id).$promise.then success, error  if confirm 'Delete ' + $scope.post.title + '?'

# Create post
postsControllers.controller 'PostsNewCtrl', ($scope, $location, flash, Post) ->
  success = (data) ->
    flash.pop 'success', 'Successfully created post.'
    $location.path '/posts'

  error = (error) -> flash.pop 'error', input + ' ' + error[0]  for input, error of error.data

  $scope.savePost = -> Post.create($scope.post).$promise.then success, error

# Update post
postsControllers.controller 'PostsEditCtrl', ($scope, $routeParams, $location, flash, Post) ->
  $scope.post = Post.index $routeParams.postId

  success = (data) ->
    flash.pop 'success', 'Successfully updated post.'
    $location.path '/posts/' + $routeParams.postId

  error = (error) -> flash.pop 'error', error.data.errors

  $scope.savePost = -> Post.update($scope.post).$promise.then success, error
