###* @jsx React.DOM ###

@app.components.SpinnerComponent = React.createClass
  displayName: 'app.components.SpinnerComponent'
  propTypes:
    isVisible: React.PropTypes.bool
    preset: React.PropTypes.object

  classes: ->
    React.addons.classSet
      "spinner": true
      "is-visible": @props.isVisible

  componentDidMount: ->
    config = @props.preset ? app.config.spinner.tiny
    @spinner = new Spinner(config).spin(@refs.spinnerEl.getDOMNode())

  render: ->
    `<div ref="spinnerEl" className={this.classes()}></div>`
