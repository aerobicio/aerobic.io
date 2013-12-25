###* @jsx React.DOM ###

@app.components.DeviceComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  classes: ->
    selected = @props.model.get('selected')
    React.addons.classSet(
      "panel": true
      "devices-list__device": true
      "is-selected": selected
      "is-not-selected": !selected
    )

  render: ->
    ProgressBarComponent = app.components.ProgressBarComponent

    `<div key={this.props.model.cid} onClick={this.props.selectDeviceHandler} className={this.classes()}>
      <a className="devices-list__device__unselect" onClick={this.props.unselectDeviceHandler}>
        Unselect
      </a>
      <h6 className="h6">{this.props.model.get('name')}</h6>
      <ProgressBarComponent model={this.props.progressModel} />
    </div>`
