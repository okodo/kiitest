flatEvent = angular.module('flatEvent', ['ui.router', 'templates', 'ui.bootstrap', 'Devise', 'mwl.calendar', 'datePicker'])

flatEvent.config [
  '$stateProvider'
  '$urlRouterProvider'
  ($stateProvider, $urlRouterProvider) ->
    $stateProvider
    .state 'home',
      url: '/home'
      templateUrl: 'events/_index.html'
      controller: 'HomeCtrl'
      onEnter: ['$state', 'Auth', (($state, Auth) -> $state.go('login') if !Auth.isAuthenticated() ) ]
      resolve:
        postPromise: ['events', ((events) -> events.getAll())]

    .state 'events',
      url: '/events/{id}'
      templateUrl: 'events/_show.html'
      controller: 'EventsCtrl'
      resolve:
        event: ['$stateParams', 'events', (($stateParams, events) -> events.get($stateParams.id))]

    .state 'login',
      url: '/login'
      templateUrl: 'devise/_login.html'
      controller: 'AuthCtrl'
      onEnter: ['$state', 'Auth', (($state, Auth) -> Auth.currentUser().then( -> $state.go('home') )) ]

    .state 'register',
      url: '/register'
      templateUrl: 'devise/_register.html'
      controller: 'AuthCtrl'
      onEnter: ['$state', 'Auth', (($state, Auth) -> Auth.currentUser().then(-> $state.go('home') ))]

    $urlRouterProvider.otherwise('login')
]
