@app.collections.DevicesCollection = class DevicesCollection extends Backbone.Collection
  model: app.models.DeviceModel

  initialize: (@models, @options = {}) ->
    @garminDelegate = @options.garminDelegate

  fetch: ->
    promise = @garminDelegate.devices()
    promise.then (devices) => @reset(devices)
    promise

  selectDevice: (cid) ->
    @unselectAllDevices()
    @get(cid).set(selected: true)

  unselectAllDevices: ->
    @findWhere(selected: true)?.set(selected: false)
