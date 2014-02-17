###* @jsx React.DOM ###

@app.components.ProgressBarComponent = React.createClass
  displayName: 'app.components.ProgressBarComponent'
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    model: React.PropTypes.object.isRequired

  getInitialState: ->
    isLoading: false
    isComplete: false

  classes: ->
    React.addons.classSet
      "progress": true
      "is-completed": @props.model.get('percent') is 100
      "is-loading": (-1 < @props.model.get('percent') < 100)

  render: ->
    percentComplete = @props.model.get('percent')
    `<progress className={this.classes()} max="100" value={percentComplete}></progress>`
