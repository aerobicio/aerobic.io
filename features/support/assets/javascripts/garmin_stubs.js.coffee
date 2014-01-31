#= require support/sinon
#= require underscore/underscore
#= require q/q

class GarminStubs
  _stubs: []
  _fitDeviceWorkouts: []
  _tcxDeviceWorkouts: []

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
      activities: => @getDeviceActivities(@_fitDeviceWorkouts)
    window.garminUploadController.devicesCollection.add(device)

  getDeviceActivities: (activitiesBuffer) ->
    deferred = Q.defer()
    deferred.resolve(activitiesBuffer)
    deferred.promise

  createFITWorkouts: (workoutsJson) ->
    _(workoutsJson).map (workoutJson) =>
      @_fitDeviceWorkouts.push(@_parseWorkoutJson(workoutJson))

  createTCXWorkouts: (workoutsJson) ->
    _(workoutsJson).map (workoutJson) =>
      @_tcxDeviceWorkouts.push(@_parseWorkoutJson(workoutJson))

  createTCXDevice: (options = {}) ->
    device = _(options).defaults
      name: "Test TCX Device"
      activities: => @getDeviceActivities(@_tcxDeviceWorkouts)
    window.garminUploadController.devicesCollection.add(device)

  _parseWorkoutJson: (workoutJson) ->
    workoutJson.date = new Date(workoutJson.date)
    workoutJson.getData = ->
      deferred = Q.defer()
      deferred.resolve(workoutJson.data)
      deferred.promise
    workoutJson

window.GarminStubs = new GarminStubs
