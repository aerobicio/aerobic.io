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

  iconClass: ->
    React.addons.classSet
      "uploader-workout__icon": true
      "is-new": !@state.checked and not @props.model.isUploading()
      "is-checked": @state.checked and not @props.model.isUploading()
      "is-uploading": @props.model.isUploading()
      "is-failed": @props.model.isFailed()

  render: ->
    SpinnerComponent = app.components.SpinnerComponent

    `<li
      key={this.props.model.cid}
      className={this.classes()}
      onClick={this.toggleChecked}
      data-workout-uuid={this.props.model.get('uuid')}
    >
      <div className="panel__header">
        <input className="workouts__list__item__checkbox" type="checkbox" checked={this.state.checked} ref="workoutCheckbox" />
        <figure className="panel__figure">
          <i className={this.iconClass()}>
            {this.props.model.isUploading() ? <SpinnerComponent preset={app.config.spinner.uploader} /> : ''}
          </i>
        </figure>
        <h6 className="panel__header__heading--padded uploader-workout__heading h6">
          {this.props.model.date()}<span> {this.props.model.dateSince()}</span>
        </h6>
      </div>
    </li>`
