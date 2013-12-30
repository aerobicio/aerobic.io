###* @jsx React.DOM ###

@app.components.ExistingWorkoutComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.model]

  classes: ->
    React.addons.classSet
      "panel": true
      "workouts__list__item": true

  render: ->
    `<li key={this.props.model.cid} className={this.classes()}>
      <div className="panel__content">
        <input type="checkbox" checked disabled />
        {this.props.model.date().toString()} - {this.props.model.get('status')}
      </div>
    </li>`
