@app.collections.DevicesCollection = class DevicesCollection extends Backbone.Collection
  model: app.models.DeviceModel

  initialize: (@models, @options) ->
    @garminDelegate = @options.garminDelegate

  fetch: ->
    promise = @garminDelegate.devices()
    promise.then (devices) => @reset(devices)

  selectDevice: (cid) ->
    @findWhere(selected: true)?.set(selected: false)
    @get(cid).set(selected: true)
