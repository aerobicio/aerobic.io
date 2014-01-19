@app.models.WorkoutModel = class WorkoutModel extends Backbone.Model
  defaults:
    status: "new"
    uuid: undefined

  initialize: ->
    if @get("uuid") is undefined
      uuidString = [@get("id"), @get("device").id].join(":")
      @set(uuid: new jsSHA(uuidString, "TEXT" ).getHash("SHA-1", "HEX"))

  date: ->
    @get('date')

  data: ->
    @attributes.getData()
