###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.collection]

  getInitialState: ->
    hasDeviceSelected: false

  render: ->
    WorkoutListHeaderComponent = app.components.WorkoutListHeaderComponent
    WorkoutListComponent = app.components.WorkoutListComponent

    `<div className={this.classes()}>
      <WorkoutListHeaderComponent collection={this.props.collection} onClick={this.onClick} />
      <WorkoutListComponent collection={this.props.collection} />
    </div>`

  classes: ->
    React.addons.classSet
      "workouts": true
      "has-device-selected": @state.hasDeviceSelected

  onClick: (event) ->
    event.preventDefault()
    @props.collection.uploadSelectedWorkouts()
