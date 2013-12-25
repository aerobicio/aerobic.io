@app.models.WorkoutModel = class WorkoutModel extends Backbone.Model
  defaults:
    status: "new"

  date: ->
    @get('date')

  data: ->
    @attributes.getData()
