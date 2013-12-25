###* @jsx React.DOM ###

@app.components.WorkoutListComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  render: ->
    workoutNodes = @workoutNodesForDevice(@props.collection)
    `<ol className="workouts__list">
      {workoutNodes}
    </ol>`

  workoutNodesForDevice: (workoutCollection) ->
    WorkoutComponent = app.components.WorkoutComponent
    ExistingWorkoutComponent = app.components.ExistingWorkoutComponent
    workoutCollection.map (workout) =>
      if workout instanceof app.models.ExistingWorkoutModel
        `<ExistingWorkoutComponent model={workout} />`
      else
        `<WorkoutComponent model={workout} />`
