@app.models.ExistingWorkoutModel = class ExistingWorkoutModel extends Backbone.Model
  defaults:
    status: "uploaded"

  date: ->
    moment(@get('start_time')).calendar()

  dateSince: ->
    "(about #{moment(@get('start_time')).fromNow()})"

  duration: ->
    @get('formatted_duration')

  activeDuration: ->
    @get('formatted_active_duration')

  distance: ->
    @get('formatted_distance')
