@app.collections.DevicesCollection = class DevicesCollection extends Backbone.Collection
  model: app.models.DeviceModel

  selectDevice: (device) ->
    @unselectAllDevices()
    @get(device.cid).set(selected: true)

  unselectAllDevices: ->
    @findWhere(selected: true)?.set(selected: false)
