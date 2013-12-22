@app.views.DevicesView = class DevicesView extends app.controllers.ViewController
  el: "#DevicesView"
  spinnerEl: ".device-selector__spinner"

  initialize: (options) ->
    @getWorkoutsDelegate = options.getWorkoutsDelegate
    @devicesCollection = options.devicesCollection

    React.renderComponent(app.components.ExampleComponent(), @el)

  onClick: (event, context) =>
    event.preventDefault()
    context.devices.findWhere(selected: true)?.set(selected: false)
    context.device.set selected: true
    @getWorkoutsDelegate(context.device)
