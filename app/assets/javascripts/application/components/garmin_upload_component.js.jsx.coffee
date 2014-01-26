###* @jsx React.DOM ###

@app.components.GarminUploadComponent = React.createClass
  getInitialState: ->
    garminIsInstalled: false

  render: ->
    DeviceListComponent = app.components.DeviceListComponent
    WorkoutsComponent = app.components.WorkoutsComponent

    if @state.garminIsInstalled
      `<div>
        <DeviceListComponent
          collection={this.props.devicesCollection}
          progressModel={this.props.progressModel}
          deviceSelectedDelegate={this.props.deviceSelectedDelegate}
          deviceUnselectedDelegate={this.props.deviceUnselectedDelegate}
        />
        <WorkoutsComponent
          collection={this.props.workoutsCollection}
        />
      </div>`
    else
      `<div>DERP</div>`
