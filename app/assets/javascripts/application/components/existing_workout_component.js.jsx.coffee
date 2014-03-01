###* @jsx React.DOM ###

@app.components.ExistingWorkoutComponent = React.createClass
  displayName: 'app.components.ExistingWorkoutComponent'
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    model: React.PropTypes.instanceOf(app.models.ExistingWorkoutModel).isRequired

  classes: ->
    React.addons.classSet
      "panel": true
      "uploader-workout": true
      "is-uploaded": true

  iconClasses: ->
    React.addons.classSet
      "panel__figure": true
      "uploader-workout-avatar": true
      "is-uploaded": true

  render: ->
    `<li
      key={this.props.model.cid}
      className={this.classes()}
      data-workout-uuid={this.props.model.get('uuid')}
    >
      <div className="panel__header">
        <figure className={this.iconClasses()}>Workout Uploaded</figure>
        <h6 className="panel__header__heading--padded uploader-workout__heading">
          <span className="h6">{this.props.model.date().toString()}</span>
          <span>{this.props.model.dateSince()}</span>
        </h6>
      </div>
      <footer className="panel__footer">
        <ul className="data-row--inline">
          <li className="data-row__item">
            <h6 className="h5">{this.props.model.activeDuration()}</h6>
            <span>Duration</span>
          </li>
          <li className="data-row__item">
            <h6 className="h5">{this.props.model.distance()}</h6>
            <span>Distance</span>
          </li>
        </ul>
      </footer>
    </li>`
