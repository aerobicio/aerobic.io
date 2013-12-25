###* @jsx React.DOM ###

@app.components.ProgressBarComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  getInitialState: ->
    isLoading: false
    isComplete: false

  classes: ->
    React.addons.classSet
      "progress": true
      "is-completed": @props.model.get('percent') is 100
      "is-loading": @props.model.get('percent') < 100

  render: ->
    percentComplete = @props.model.get('percent')
    `<progress className={this.classes()} max="100" value={percentComplete}></progress>`
