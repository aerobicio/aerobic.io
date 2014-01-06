@app.models.ExistingWorkoutModel = class ExistingWorkoutModel extends Backbone.Model
  defaults:
    status: "uploaded"

  date: ->
    new Date(@get('start_time'))
