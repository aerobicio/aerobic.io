@app.collections.WorkoutsCollection = class WorkoutsCollection extends Backbone.Collection
  model: app.models.WorkoutModel

  initialize: (@models, @options) ->
    @updateProgressDelegate = @options?.updateProgressDelegate

  fetch: (device) ->
    @reset()
    promise = device.getActivities()
    promise.progress(@updateProgressDelegate)
    promise.then (workouts) => @reset(workouts)

  selectedWorkouts: ->
    @where(checked: true)

