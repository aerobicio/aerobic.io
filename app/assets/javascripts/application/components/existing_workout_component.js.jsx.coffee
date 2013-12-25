###* @jsx React.DOM ###

@app.components.ExistingWorkoutComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  classes: ->
    React.addons.classSet
      "workouts__list__item": true
      "panel": true

  render: ->
    `<li key={this.props.model.cid} className={this.classes()} onClick={this.toggleChecked}>
      <div className="panel__content">
        <input type="checkbox" checked disabled />
        {this.props.model.date().toString()} - {this.props.model.get('status')}
      </div>
    </li>`
