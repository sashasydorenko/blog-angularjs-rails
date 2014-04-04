postsServices = angular.module 'postsServices', ['ngResource']

postsServices.factory 'Post', ($resource) ->
  Post = -> 
    @service = $resource '/api/posts/:postId', postId: '@id',
      update: method: 'PUT'
    return

  Post::all = -> @service.query()

  Post::index = (psId) -> @service.get postId: psId

  Post::create = (attr) -> @service.save attr

  Post::update = (attr) -> @service.update attr

  Post::delete = (psId) -> @service.remove postId: psId

  new Post
