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
    SpinnerComponent = app.components.SpinnerComponent

    `<li
      key={this.props.model.cid}
      className={this.classes()}
      onClick={this.toggleChecked}
      data-workout-uuid={this.props.model.get('uuid')}
    >
      <input className="workouts__list__item__checkbox" type="checkbox" checked={this.state.checked} ref="workoutCheckbox" />
      <div className="panel__content--padded">
        <h6 className="h6">
          {this.props.model.date()} <span>{this.props.model.dateSince()}</span>
        </h6>
        <SpinnerComponent />
      </div>
    </li>`
