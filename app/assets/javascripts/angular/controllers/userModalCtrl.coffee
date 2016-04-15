angular.module('flatEvent').controller('userModalCtrl', [
  '$scope'
  '$modalInstance'
  '$http'
  'Auth'
  ($scope, $modalInstance, $http, Auth) ->
    $scope.form = {}
    $scope.fullname = $scope.user.fullname
    $scope.email = $scope.user.email
    $scope.password = ''
    $scope.email = $scope.user.email
    $scope.updateUser = ->
      if $scope.form.userForm.$valid
        $http.put('/users/' + $scope.user.id + '.json', {
          fullname: $scope.fullname,
          email: $scope.email,
          password: $scope.password,
          password_confirmation: $scope.password_confirmation
        }).success (data) ->
          Auth.login(data.user)
          return

      $scope.password = ''
      $scope.password_confirmation = ''
      $modalInstance.close('closed')

    $scope.cancel =  -> $modalInstance.dismiss('cancel')

  ])