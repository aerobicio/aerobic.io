###* @jsx React.DOM ###

@app.components.DeviceListComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.DevicesCollection).isRequired
    progressModel: React.PropTypes.instanceOf(app.models.ProgressModel).isRequired
    hasDeviceSelected: React.PropTypes.bool.isRequired
    onDeviceSelectDelegate: React.PropTypes.func.isRequired
    onDeviceUnselectDelegate: React.PropTypes.func.isRequired

  classes: ->
    React.addons.classSet
      "device-list": true
      "has-device-selected": @props.hasDeviceSelected

  render: ->
    deviceNodes = @deviceNodes(@props.collection)

    `<nav className={this.classes()}>
      {deviceNodes}
    </nav>`

  deviceNodes: (deviceCollection) ->
    if deviceCollection.length
      deviceCollection.map @deviceNode
    else
      `<div>Uh oh, we couldn’t find any devices!</div>`

  deviceNode: (model) ->
    deviceComponent = app.components.DeviceComponent
    `<deviceComponent
      key={model.cid}
      model={model}
      progressModel={this.props.progressModel}
      onDeviceSelectDelegate={this.props.onDeviceSelectDelegate}
      onDeviceUnselectDelegate={this.props.onDeviceUnselectDelegate}
    />`
