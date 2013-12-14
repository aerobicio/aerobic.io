@app.models.DeviceModel = class DeviceModel extends Backbone.Model
  defaults:
    selected: false

  name: ->
    @get('name')

  software_version: ->
    @get('software_version')

  getActivities: ->
    @attributes.activities()
