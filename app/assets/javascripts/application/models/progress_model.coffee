@app.models.ProgressModel = class ProgressModel extends Backbone.Model
  defaults:
    percent: -1
    message: ""

  isComplete: ->
    @get('percent') is 100

  isEmpty: ->
    @get('percent') is @defaults.percent
