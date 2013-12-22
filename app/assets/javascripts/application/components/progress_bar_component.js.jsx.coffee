###* @jsx React.DOM ###

@app.components.ProgressBarComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  classes: ->
    React.addons.classSet
      "is-completed": @getPercentage() is 100

  render: ->
    percentage = @getPercentage()
    `<progress className={this.classes()} max="100" value={percentage}></progress>`

  getPercentage: ->
    @props.model.get('percent')
