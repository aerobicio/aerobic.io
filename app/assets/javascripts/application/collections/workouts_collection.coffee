@app.collections.WorkoutsCollection = class WorkoutsCollection extends Backbone.Collection
  sort_order: 'asc'
  queueUploadRequests: true

  initialize: (@models, @options = {}) ->
    @uploadPath = @options.uploadPath

  comparator: (workout) ->
    - workout.date()

  model: (attrs, options) ->
    if attrs.created_at?
      new app.models.ExistingWorkoutModel(attrs, options)
    else
      new app.models.WorkoutModel(attrs, options)

  fetch: (device) ->
    @reset([])
    promise = device.getActivities()
    promise.then (workouts) => @reset(workouts)
    promise

  selectAll: ->
    @map (model) ->
      model.set(checked: true)

  selectedWorkouts: ->
    @where(checked: true)

  getSelectedWorkoutsCount: ->
    @selectedWorkouts()?.length || 0

  getWorkoutsForDeviceId: (deviceId) ->
    @where(device_id: deviceId)

  uploadSelectedWorkouts: ->
    @selectedWorkouts().map (workout) =>
      workout.data().then (data) =>
        @uploadWorkout(workout, data)

  uploadWorkout: (workout, data) ->
    @onUploadStarted(workout)
    request = jQuery.ajax
      type: "POST"
      url: @uploadPath
      data: @workoutData(workout, data)
      dataType: 'json'
      queue: @queueUploadRequests
    request.done (responseData) => @onUploadDone(workout, responseData)
    request.fail (responseData) => @onUploadFail(workout)
    request

  workoutData: (workout, data) ->
    activity: data
    device_id: workout.get('device').id
    device_workout_id: workout.get('id')
    uuid: workout.get('uuid')

  onUploadStarted: (workout) ->
    workout.set(status: 'uploading')

  onUploadDone: (workout, responseData) ->
    responseData.status = 'uploaded'
    @models[@indexOf(workout)] = @model(responseData)
    @trigger('change');

  onUploadFail: (workout) ->
    workout.set(status: 'failed')
