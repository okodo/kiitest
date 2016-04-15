angular.module('flatEvent').controller('HomeCtrl', [
  '$scope'
  '$modal'
  '$state'
  'events'
  ($scope, $modal, $state, events) ->

    $scope.showForm = (event) ->
      $scope.event = event

      modalInstance = $modal.open(
        templateUrl: 'modals/_event_modal.html'
        controller: 'ModalCtrl'
        scope: $scope
        resolve:
          eventForm: -> $scope.eventForm
      )

      modalInstance.result.then( (selectedItem) ->
        $scope.selected = selectedItem
        $scope.events = events.events

      )

    $scope.showAll = ->
      events.getAll({all: 1})
      $scope.viewMode = 'all'
      $scope.events = events.events

    $scope.showMy = ->
      events.getAll()
      $scope.viewMode = 'my'
      $scope.events = events.events

    $scope.eventEdited = (calendarEvent) ->
      $scope.showForm(calendarEvent)

    $scope.eventDeleted = (calendarEvent) ->
      events.destroy(calendarEvent.id)
      $scope.events.pop(calendarEvent)

    $scope.eventClicked = (calendarEvent) ->
      $state.go('events', { id: calendarEvent.id })

    $scope.viewMode = 'my'
    $scope.events = events.events
    $scope.calendarView = 'month'
    $scope.calendarDay =  new Date()
    $scope.changeCalendarView = ((view_type) -> $scope.calendarView = view_type)

])
