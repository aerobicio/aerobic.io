@app.views.DevicesView = class DevicesView extends app.controllers.BoundViewController
  el: "#DevicesView"
  spinnerEl: ".device-selector__spinner"

  initialize: (options) ->
    @getWorkoutsDelegate = options.getWorkoutsDelegate

  _showSpinner: ->
    @spinner = new Spinner(app.config.spinner.small).spin()
    @$el.find(@spinnerEl)[0].appendChild(@spinner.el)

  onClick: (event, context) =>
    event.preventDefault()
    context.devices.findWhere(selected: true)?.set(selected: false)
    context.device.set selected: true
    @getWorkoutsDelegate(context.device)
