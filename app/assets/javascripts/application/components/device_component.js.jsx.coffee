###* @jsx React.DOM ###

@app.components.DeviceComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.model]

  getInitialState: ->
    isSelected: false

  classes: ->
    selected = @props.model.get('selected')

    React.addons.classSet(
      "panel": true
      "devices-list__device": true
      "is-selected": @state.isSelected
      "is-not-selected": !@state.isSelected
    )

  onClick: (event) ->
    event.preventDefault()
    unless @state.isSelected
      @props.selectDeviceHandler(event)
      @setState(isSelected: true)

  onClickUnselect: (event) ->
    event.preventDefault()
    if @state.isSelected
      @setState(isSelected: false)
      @props.unselectDeviceHandler(event)

  render: ->
    ProgressBarComponent = app.components.ProgressBarComponent
    SVGImageReplaceComponent = app.components.SVGImageReplaceComponent

    `<div
      key={this.props.model.cid}
      onClick={this.onClick}
      className={this.classes()}
    >
      <SVGImageReplaceComponent src={this.props.model.icon()} className="devices-list__device__icon" />
      <a className="devices-list__device__unselect" onClick={this.onClickUnselect}>
        Unselect
      </a>
      <footer className="panel__footer--padded">
        <h6 className="h6">{this.props.model.get('name')}</h6>
        <ProgressBarComponent model={this.props.progressModel} />
      </footer>
    </div>`
