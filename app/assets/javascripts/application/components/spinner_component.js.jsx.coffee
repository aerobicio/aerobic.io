###* @jsx React.DOM ###

@app.components.SpinnerComponent = React.createClass
  getInitialState: ->
    preset: @props.preset ? app.config.spinner.tiny
    visible: @props.isVisible ? true

  classes: ->
    React.addons.classSet
      "spinner": true

  componentDidMount: ->
    el = @refs.spinnerEl.getDOMNode()
    @spinner = new Spinner(@state.preset).spin(el)

  render: ->
    TransitionGroup = React.addons.TransitionGroup
    `<TransitionGroup transitionName="spinner" component={React.DOM.figure}>
      <div ref="spinnerEl" className={this.classes()}></div>
    </TransitionGroup>`
