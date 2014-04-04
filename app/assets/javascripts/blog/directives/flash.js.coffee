flash = angular.module "flashDirectives", ["ngAnimate"]

flash.service "flash", ($rootScope) ->
  @pop = (type, title, body, timeout) ->
    @fl =
      type: type
      title: title
      body: body
      timeout: timeout

    $rootScope.$broadcast "newFlash"

  @clear = -> $rootScope.$broadcast "clearFlashes"

  return

flash.constant "flashConfig",
  limit: 10
  "time-out": 3000
  "type-classes":
    error: "flash-error"
    info: "flash-info"
    success: "flash-success"
    warning: "flash-warning"

flash.directive "flash", ($compile, $timeout, $sce, flashConfig, flash) ->
  replace: true
  restrict: "EA"
  scope: true
  link: (scope, elm, attrs) ->
    id = 0

    scope.configureTimer = configureTimer = (fl) ->
      timeout = (if typeof (fl.timeout) is "number" then fl.timeout else flashConfig["time-out"])
      setTimeout fl, timeout  if timeout > 0

    scope.flashes = []
    scope.$on "newFlash", -> addFlash flash.fl
    scope.$on "clearFlashes", -> scope.flashes.splice 0, scope.flashes.length

    addFlash = (fl) ->
      fl.type = flashConfig["type-classes"][fl.type]
      id++
      angular.extend fl, id: id
      
      scope.configureTimer fl
      scope.flashes.unshift fl
      scope.flashes.pop()  if flashConfig["limit"] > 0 and scope.flashes.length > flashConfig["limit"]

    setTimeout = (fl, time) ->
      fl.timeout = $timeout(->
        scope.removeFlash fl.id
      , time)

  controller: ($scope, $element, $attrs) ->
    $scope.stopTimer = (fl) ->
      if fl.timeout
        $timeout.cancel fl.timeout
        fl.timeout = null

    $scope.restartTimer = (fl) -> $scope.configureTimer fl  unless fl.timeout

    $scope.removeFlash = (id) ->
      i = 0
      while i < $scope.flashes.length
        break  if $scope.flashes[i].id is id
        i++
      $scope.flashes.splice i, 1

    $scope.remove = (id) -> $scope.removeFlash id

  template: 
    '<div id="flash-container">' +
      '<div ng-repeat="flash in flashes" class="flash" ng-class="flash.type" ng-click="remove(flash.id)" ng-mouseover="stopTimer(flash)"  ng-mouseout="restartTimer(flash)">' + 
        '<div class="flash-title">{{flash.title}}</div>' + 
        '<div class="flash-message">{{flash.body}}</div>' + 
      '</div>' + 
    '</div>'
