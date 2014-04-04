usersServices = angular.module 'usersServices', ['ngResource']

usersServices.factory 'Auth', ($resource) ->
  Auth = -> 
    @service = $resource '/api/users/:sign', sign: '@sign'
    return

  Auth::sign_in = (attr) -> @service.save sign: 'sign_in', attr

  Auth::sign_up = (attr) -> @service.save attr

  Auth::sign_out = -> @service.remove sign: 'sign_out'

  new Auth
