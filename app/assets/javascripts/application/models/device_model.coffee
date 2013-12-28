@app.models.DeviceModel = class DeviceModel extends Backbone.Model
  defaults:
    selected: false

  getActivities: ->
    @attributes.activities()
