###* @jsx React.DOM ###

@app.components.DeviceComponent = React.createClass
  displayName: 'app.components.DeviceComponent'
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    model: React.PropTypes.instanceOf(app.models.DeviceModel).isRequired
    progressModel: React.PropTypes.instanceOf(app.models.ProgressModel).isRequired
    onDeviceSelectDelegate: React.PropTypes.func.isRequired
    onDeviceUnselectDelegate: React.PropTypes.func.isRequired

  classes: ->
    React.addons.classSet
      "device-list__device": true
      "is-selected": @isSelected()
      "is-not-selected": not @isSelected()

  onClick: (event) ->
    event.stopPropagation()
    event.preventDefault()

    if @isSelected()
      @props.model.collection.unselectAllDevices()
      @props.onDeviceUnselectDelegate(@props.model)
    else
      @props.model.collection.selectDevice(@props.model)
      @props.onDeviceSelectDelegate(@props.model)

  isSelected: ->
    @props.model.get('selected') is true

  render: ->
    ProgressBarComponent = app.components.ProgressBarComponent

    `<div
      key={this.props.model.cid}
      onClick={this.onClick}
      className={this.classes()}
    >
      <header className="device-list__device__header">
        <h6 className="device-list__device__label h6">{this.props.model.get('name')}</h6>
      </header>
      <img src={this.props.model.icon()} className="devices-list__device__icon" />
      {this.isSelected() ? this.renderUnselect() : ''}
      <footer className="device-list__device__footer">
        {this.isSelected() ? <ProgressBarComponent model={this.props.progressModel} /> : ''}
      </footer>
    </div>`

  renderUnselect: ->
    `<a className="devices-list__device__unselect" onClick={this.onClick}>
      Unselect
    </a>`
