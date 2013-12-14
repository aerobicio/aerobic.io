@app.collections.DevicesCollection = class DevicesCollection extends Backbone.Collection
  model: app.models.DeviceModel

  initialize: (@models, @options) ->
    @garminDelegate = @options.garminDelegate
    @fetch()

  fetch: ->
    promise = @garminDelegate.devices()
    promise.then (devices) => @reset(devices)
