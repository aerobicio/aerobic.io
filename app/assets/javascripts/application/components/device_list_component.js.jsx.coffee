###* @jsx React.DOM ###

@app.components.DeviceListComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.collection]

  getInitialState: ->
    isLoading: true
    hasDeviceSelected: false

  classes: ->
    React.addons.classSet
      "devices-list": true
      "has-device-selected": @state.hasDeviceSelected

  render: ->
    SpinnerComponent = app.components.SpinnerComponent
    deviceNodes = @deviceNodesForDevices(@props.collection)

    `<nav className={this.classes()}>
      <SpinnerComponent preset={app.config.spinner.small} isVisible={this.state.isLoading} />
      {deviceNodes}
    </nav>`

  onSelectDevice: (device, event) ->
    event.preventDefault()
    event.stopPropagation()
    @props.collection.selectDevice(device)
    @setState(hasDeviceSelected: true)
    @props.deviceSelectedDelegate(device)

  onUnselectDevice: (event) ->
    event.preventDefault()
    event.stopPropagation()
    @setState(hasDeviceSelected: false)
    @props.collection.unselectAllDevices()
    @props.deviceUnselectedDelegate()

  deviceNodesForDevices: (devicesCollection) ->
    if devicesCollection.length
      devicesCollection.map (device) =>
        onSelectDeviceHandler = @onSelectDevice.bind(@, device)
        @deviceNode(device, @props.progressModel, onSelectDeviceHandler, @onUnselectDevice)
    else
      @noDeviceNode()

  noDeviceNode: ->
    `<div className="devices-list__no-devices">
      Uh oh, we couldn’t find any devices!
    </div>`

  deviceNode: (model, progressModel, selectDeviceHandler, unselectDeviceHandler) ->
    deviceComponent = app.components.DeviceComponent
    `<deviceComponent key={model.cid}
                      model={model}
                      progressModel={progressModel}
                      selectDeviceHandler={selectDeviceHandler}
                      unselectDeviceHandler={unselectDeviceHandler} />`
