#= require support/sinon
#= require underscore/underscore
#= require q/q

class GarminStubs
  _stubs: []
  _fitDeviceWorkouts: []

  constructor: ->
    @_stubs['Garmin.unlock']  = @_stubGarminUnlock()
    @_stubs['Garmin.devices'] = @_stubGarminDevices()

  _stubGarminUnlock: ->
    sinon.stub(Garmin.prototype, 'unlock')

  _stubGarminDevices: ->
    deferred = Q.defer()
    deferred.resolve([])
    sinon.stub(Garmin.prototype, 'devices').returns(deferred.promise)
    deferred.promise

  restoreAll: ->
    _.invoke(@_stubs, 'restore')

  createFITDevice: (options = {}) ->
    device = _(options).defaults
      name: "Test FIT Device"
      activities: => @getFitActivities()
    window.garminUploadController.devicesCollection.add(device)

  getFitActivities: ->
    deferred = Q.defer()
    deferred.resolve(@_fitDeviceWorkouts)
    deferred.promise

  createFITWorkouts: (workoutsJson) ->
    _(workoutsJson).map (workout) =>
      workout.date = new Date(workout.date)
      workout.getData = ->
        deferred = Q.defer()
        deferred.resolve(workout.data)
        deferred.promise
      @_fitDeviceWorkouts.push(workout)

  createTCXDevice: (options = {}) ->
    device = _(options).defaults
      name: "Test TCX Device"
      activities: -> []
    window.garminUploadController.devicesCollection.add(device)

window.GarminStubs = new GarminStubs
