@app.models.ProgressModel = class ProgressModel extends Backbone.Model
  defaults:
    percent: -1
    message: ""

  constructor: ->
    @on "change:percent", (model, value) ->
      @trigger("complete") if @isComplete()
      @trigger("empty") if @isEmpty()
    super()

  isComplete: ->
    @get('percent') is 100

  isEmpty: ->
    @get('percent') is @defaults.percent
