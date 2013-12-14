@app.models.WorkoutModel = class WorkoutModel extends Backbone.Model
  defaults:
    checked: false
    status: false

  getData: ->
    @attributes.getData()
