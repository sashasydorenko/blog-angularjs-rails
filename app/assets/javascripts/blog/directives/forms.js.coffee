formsDirectives = angular.module 'formsDirectives', []
 
formsDirectives.directive 'equals', ->
  restrict: 'A',
  require: '?ngModel',
  link: (scope, elem, attrs, ngModel) ->
    return false unless ngModel

    scope.$watch attrs.ngModel, -> validate()

    attrs.$observe 'equals', (val) -> validate()

    validate = ->
      val1 = ngModel.$viewValue
      val2 = attrs.equals

      ngModel.$setValidity 'equals', val1 is val2
