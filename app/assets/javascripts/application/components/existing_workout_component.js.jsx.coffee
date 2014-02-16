###* @jsx React.DOM ###

@app.components.ExistingWorkoutComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    model: React.PropTypes.instanceOf(app.models.ExistingWorkoutModel).isRequireds

  classes: ->
    React.addons.classSet
      "panel": true
      "workouts__list__item": true
      "is-uploaded": true

  render: ->
    `<li
      key={this.props.model.cid}
      className={this.classes()}
      data-workout-uuid={this.props.model.get('uuid')}
    >
      <input className="workouts__list__item__checkbox" type="checkbox" checked disabled />
      <div className="panel__header--padded">
        <h6 className="h6">
          {this.props.model.date().toString()} <span>{this.props.model.dateSince()}</span>
        </h6>
      </div>
      <ul className="data-row">
        <li className="data-row__item">
          <h6 className="h3 data-row__item__value">{this.props.model.activeDuration()}</h6>
          <span className="data-row__item__key">Duration</span>
        </li>
        <li className="data-row__item">
          <h6 className="h3 data-row__item__value">{this.props.model.distance()}</h6>
          <span className="data-row__item__key">Distance</span>
        </li>
      </ul>
    </li>`
