@app.collections.WorkoutsCollection = class WorkoutsCollection extends Backbone.Collection
  model: app.models.WorkoutModel

  initialize: (@models, @options) ->
    @updateProgressDelegate = @options?.updateProgressDelegate

  fetch: (device) ->
    @reset()
    promise = device.getActivities()
    promise.progress(@updateProgressDelegate)
    promise.then (workouts) => @reset(workouts)

  selectAll: ->
    @map (model) ->
      model.set(checked: true)

  selectedWorkouts: ->
    @where(checked: true)

  getSelectedWorkoutsCount: ->
    @selectedWorkouts()?.length || 0

