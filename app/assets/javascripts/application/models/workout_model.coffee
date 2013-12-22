@app.models.WorkoutModel = class WorkoutModel extends Backbone.Model
  data: ->
    @attributes.getData()
