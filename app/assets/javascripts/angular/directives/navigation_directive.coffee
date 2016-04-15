angular.module('flatEvent').directive "flateventNavigation", ->
  restrict: 'E'
  templateUrl: "application/_navigation.html"
  controller: [
    '$scope'
    '$modal'
    'Auth'
    ($scope, $modal, Auth) ->
      $scope.signedIn = Auth.isAuthenticated
      $scope.logout = Auth.logout
      $scope.user = Auth.currentUser()
      Auth.currentUser().then(((user) -> $scope.user = user));

      $scope.$on 'devise:new-registration', ((e, user) -> $scope.user = user)

      $scope.$on 'devise:login', ((e, user) ->  $scope.user = user)

      $scope.$on 'devise:logout', (e, user) ->
        $scope.user = {}
        window.location.href = "#/login"
        window.location.reload()

      $scope.showUserModal = ->
        modalInstance = $modal.open(
          templateUrl: 'modals/_user_modal.html'
          controller: 'userModalCtrl'
          scope: $scope
          resolve:
            userForm: -> $scope.userForm
        )

        modalInstance.result.then( (userItem) ->
          $scope.selected = userItem
        )
  ]
