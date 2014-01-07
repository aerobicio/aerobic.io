###* @jsx React.DOM ###

@app.components.ExistingWorkoutComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.model]

  classes: ->
    React.addons.classSet
      "panel": true
      "workouts__list__item": true
      "is-uploaded": true

  render: ->
    `<li key={this.props.model.cid} className={this.classes()} data-workout-uuid={this.props.model.get('uuid')}>
      <div className="panel__content">
        <input type="checkbox" checked disabled />
        <strong>{this.props.model.date().toString()}</strong>: {this.props.model.get('status')}
        <br />
        {this.props.model.get('uuid')}
        <ul>
          <li>Distance: {this.props.model.get('distance')}</li>
          <li>Duration: {this.props.model.get('duration')}</li>
        </ul>
      </div>
    </li>`
