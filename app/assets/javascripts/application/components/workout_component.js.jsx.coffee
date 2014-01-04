###* @jsx React.DOM ###

@app.components.WorkoutComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.model]

  getInitialState: ->
    checked: false

  toggleChecked: (event) ->
    event.preventDefault()
    checkedState = !@refs.workoutCheckbox.getDOMNode().checked
    @setState(checked: checkedState)
    @props.model.set(checked: checkedState)

  classes: ->
    React.addons.classSet
      "panel": true
      "workouts__list__item": true
      "is-checked": @state.checked
      "is-new": @props.model.get('status') == "new"
      "is-uploading": @props.model.get('status') == "uploading"
      "is-uploaded": @props.model.get('status') == "uploaded"
      "is-failed": @props.model.get('status') == "failed"

  render: ->
    `<li key={this.props.model.cid} className={this.classes()} onClick={this.toggleChecked} data-workout-uuid={this.props.model.get('uuid')}>
      <div className="panel__content">
        <input type="checkbox" checked={this.state.checked} ref="workoutCheckbox" />
        {this.props.model.date().toString()} - {this.props.model.get('status')}
        <br />
        {this.props.model.get('uuid')}
      </div>
    </li>`
