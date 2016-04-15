angular.module('flatEvent').controller('AuthCtrl', [
  '$scope'
  '$state'
  'Auth'
  ($scope, $state, Auth) ->
    $scope.loginErrors = null
    $scope.login = -> 
      Auth.login($scope.user).then ( -> 
        $state.go('home')
        $scope.loginErrors = null 
      ), (err) ->
        $scope.loginErrors = "1"
    $scope.register = ->
      Auth.register($scope.user).then ( -> 
        $state.go('home') 
        $scope.loginErrors = null 
      ), (err) ->
        $scope.loginErrors = err.data.errors
])
