###* @jsx React.DOM ###

@app.components.WorkoutComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  getInitialState: ->
    checked: false

  onChange: ->
    @setState(checked: !@state.checked)
    @props.model.set(checked: !@state.checked)

  classes: ->
    React.addons.classSet
      "is-checked": @state.checked

  render: ->
    checked = @state.checked
    `<li className={this.classes()}>
      <label>
        <input type="checkbox" checked={checked} onChange={this.onChange} />
        [{this.state.checked.toString()}] - {this.props.model.get('date').toString()}
        {this.props.model.get('status')}
      </label>
    </li>`
