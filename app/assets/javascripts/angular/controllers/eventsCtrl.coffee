angular.module('flatEvent').controller('EventsCtrl', [
  '$scope'
  'events'
  'event'
  ($scope, events, event) ->
    $scope.event = event
    $scope.addComment = ->
      events
        .addComment(event.id, { body: $scope.body })
        .success((response) ->
          $scope.event.comments.push(response.comment)
        )
      $scope.body = ''
])
