###* @jsx React.DOM ###

@app.components.WorkoutComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    model: React.PropTypes.instanceOf(app.models.WorkoutModel).isRequired

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
      "is-uploading": @props.model.isUploading()
      "is-failed": @props.model.isFailed()

  render: ->
    `<li
      key={this.props.model.cid}
      className={this.classes()}
      onClick={this.toggleChecked}
      data-workout-uuid={this.props.model.get('uuid')}
    >
      <input className="workouts__list__item__checkbox" type="checkbox" checked={this.state.checked} ref="workoutCheckbox" />
      <div className="panel__content--padded">
        <h6 className="h6">
          {this.props.model.date()}<span> {this.props.model.dateSince()}</span>
        </h6>
        {this.renderStatus()}
      </div>
    </li>`

  renderStatus: ->
    SpinnerComponent = app.components.SpinnerComponent

    `<div>
      {this.props.model.isUploading() ? 'Uploading Workout' + <SpinnerComponent /> : ''}
      {this.props.model.isFailed() ? 'Upload Failed' : ''}
    </div>`
