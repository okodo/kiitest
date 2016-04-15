angular.module('flatEvent').controller('ModalCtrl', [
  '$scope'
  '$modalInstance'
  '$filter'
  'events'
  ($scope, $modalInstance, $filter, events) ->
    $scope.form = {}
    $scope.types = [{name: "No recursion", value: "n_a"}, {name: "Daily", value: "day"},
      {name: "Weekly", value: "week"} ,{name: "Monthly", value: "month"} ,{name: "Yearly", value: "year"}]
    $scope.starts_at = new Date()
    $scope.title = $scope.event.title if $scope.event
    $scope.starts_at = $filter("date")($scope.event.starts_at, 'dd.MM.yyyy HH:mm') if $scope.event
    $scope.recurs_on = $scope.event.recurs_on if $scope.event
    $scope.addEvent = ->
      if $scope.event
        if $scope.form.eventForm.$valid
          events.update({
            id: $scope.event.id,
            title: $scope.title,
            starts_at: $scope.form.eventForm.starts_at.$viewValue,
            recurs_on: $scope.recurs_on
          })
      else
        if $scope.form.eventForm.$valid
          events.create({
            title: $scope.title,
            starts_at: $scope.form.eventForm.starts_at.$viewValue,
            recurs_on: $scope.recurs_on
          })
      $scope.title = ''
      $scope.starts_at = ''
      $scope.recurs_on = ''
      $modalInstance.close('closed')

    $scope.cancel =  -> $modalInstance.dismiss('cancel')

  ])
