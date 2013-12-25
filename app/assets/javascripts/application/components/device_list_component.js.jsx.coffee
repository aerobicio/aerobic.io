###* @jsx React.DOM ###

@app.components.DeviceListComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  getInitialState: ->
    isLoading: true
    hasDeviceSelected: false

  componentDidMount: ->
    promise = @props.collection.fetch()
    promise.then(@devicesDidFinishLoading)

  classes: ->
    React.addons.classSet
      "devices-list": true
      "has-device-selected": @state.hasDeviceSelected

  render: ->
    TransitionGroup = React.addons.TransitionGroup
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

  devicesDidFinishLoading: ->
    @setState(isLoading: false)

  deviceNodesForDevices: (devicesCollection) ->
    deviceComponent = app.components.DeviceComponent
    devicesCollection.map (device, index) =>
      onSelectDeviceHandler = @onSelectDevice.bind(@, device)
      onUnselectDeviceHandler = @onUnselectDevice
      progressModel = @props.progressModel
      `<deviceComponent model={device}
                        progressModel={progressModel}
                        selectDeviceHandler={onSelectDeviceHandler}
                        unselectDeviceHandler={onUnselectDeviceHandler} />`
