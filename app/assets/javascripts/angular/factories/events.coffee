angular.module('flatEvent').factory 'events', [
  '$http'
  'Auth'
  ($http, Auth) ->
    o = events: []

    o.getAll = (all) ->
      $http({url: '/events.json', method: "GET", params: all}).success (data) ->
        _.each data, (n) ->
          n['startsAt'] = new Date(n['starts_at'])
          n['editable'] = Auth._currentUser.id == n["user_id"]
          n['deletable'] = Auth._currentUser.id == n["user_id"]
          return
        angular.copy data, o.events
        return

    o.update = (event) ->
      $http.put('/events/' + event.id + '.json', event).success (data) ->
        idx = _.findIndex(o.events, (el) -> el.id == data.id);
        data['event']['startsAt'] = new Date(data['event']['starts_at'])
        data['event']['editable'] = Auth._currentUser.id == data['event']['user_id']
        data['event']['deletable'] = uth._currentUser.id == data['event']['user_id']
        o.events.pop idx
        o.events.push data['event']
        return

    o.destroy = (id) ->
      $http.delete('/events/' + id + '.json').success (data) ->
        return

    o.create = (event) ->
      $http.post('/events.json', event).success (data) ->
        data['event']['startsAt'] = new Date(data['event']['starts_at'])
        data['event']['editable'] = Auth._currentUser.id == data['event']['user_id']
        data['event']['deletable'] = uth._currentUser.id == data['event']['user_id']
        o.events.push data['event']
        return

    o.get = (id) ->
      $http.get('/events/' + id + '.json').then (result) ->
        result.data.event

    o.addComment = (id, comment) ->
      $http.post '/events/' + id + '/comments.json', comment

    o
]
