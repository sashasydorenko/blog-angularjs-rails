routes = angular.module 'routes', ['ngRoute']

routes.config ($routeProvider) ->
  # Routes
  $routeProvider
    # posts
    .when '/posts',
      templateUrl: '/assets/posts/list.html'
      controller: 'PostsListCtrl'

    .when '/posts/new',
      templateUrl: '/assets/posts/new.html'
      controller: 'PostsNewCtrl'
      access_admin: true

    .when '/posts/:postId',
      templateUrl: '/assets/posts/detail.html'
      controller: 'PostsDetailCtrl'

    .when '/posts/:postId/edit',
      templateUrl: '/assets/posts/edit.html'
      controller: 'PostsEditCtrl'
      access_admin: true

    #users
    .when '/login',
      templateUrl: '/assets/users/sign_in.html'
      controller: 'SignInCtrl'

    .when '/registration',
      templateUrl: '/assets/users/sign_up.html'
      controller: 'SignUpCtrl'

    .when '/logout',
      template: ''
      controller: 'SignOutCtrl'

    .otherwise redirectTo: '/posts'
