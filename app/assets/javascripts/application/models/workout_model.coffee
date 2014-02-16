@app.models.WorkoutModel = class WorkoutModel extends Backbone.Model
  defaults:
    status: "new"
    uuid: undefined

  initialize: ->
    @set(format: @_workoutFormat())
    @set(uuid: @_workoutUuid()) if @get("uuid") is undefined
    console.log @get('format')

  date: ->
    moment(@get('date')).calendar()

  dateSince: ->
    "(about #{moment(@get('date')).fromNow()})"

  data: ->
    @_data ||= @attributes.getData()

  isUploading: ->
    @get('status') is "uploading"

  isUploaded: ->
    @get('status') is "uploaded"

  isFailed: ->
    @get('status') is "failed"

  _workoutUuid: ->
    uuidString = [@get("id"), @get("device").id].join(":")
    new jsSHA(uuidString, "TEXT" ).getHash("SHA-1", "HEX")

  _workoutFormat: ->
    if @attributes.device.canReadFITActivities is true
      "fit"
    else if @attributes.device.canReadActivities is true
      "tcx"
    else
      null
