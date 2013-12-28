@app.collections.WorkoutsCollection = class WorkoutsCollection extends Backbone.Collection
  sort_order: 'asc'

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
