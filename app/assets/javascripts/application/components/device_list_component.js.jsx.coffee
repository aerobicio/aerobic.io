###* @jsx React.DOM ###

@app.components.DeviceListComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  getInitialState: ->
    hasDeviceSelected: false

  componentDidMount: ->
    @props.collection.fetch()

  classes: ->
    React.addons.classSet
      "uploader__devices__list": true
      "has-device-selected": @state.hasDeviceSelected

  render: ->
    deviceNodes = @deviceNodesForDevices(@props.collection)
    `<nav className={this.classes()}>
      {deviceNodes}
    </nav>`

  onClick: (device, event) ->
    @props.collection.selectDevice(device)
    @setState(hasDeviceSelected: true)
    @props.getWorkoutsDelegate(device)

  deviceNodesForDevices: (devicesCollection) ->
    deviceComponent = app.components.DeviceComponent
    devicesCollection.map (device, index) =>
      onClickHandler = @onClick.bind(@, device)
      `<deviceComponent onClick={onClickHandler} model={device} />`
