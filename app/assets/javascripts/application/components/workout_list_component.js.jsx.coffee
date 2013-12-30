###* @jsx React.DOM ###

@app.components.WorkoutListComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.collection]

  render: ->
    workoutNodes = @workoutNodesForDevice(@props.collection)
    `<ol className="workouts__list">
      {workoutNodes}
    </ol>`

  workoutNodesForDevice: (workoutCollection) ->
    workoutCollection.map (workout) =>
      @workoutNodeForWorkout(workout)

  workoutNodeForWorkout: (model) ->
    if model instanceof app.models.ExistingWorkoutModel
      @existingWorkoutNode(model)
    else
      @workoutNode(model)

  existingWorkoutNode: (model) ->
    ExistingWorkoutComponent = app.components.ExistingWorkoutComponent
    `<ExistingWorkoutComponent key={model.cid} model={model} />`

  workoutNode: (model) ->
    WorkoutComponent = app.components.WorkoutComponent
    `<WorkoutComponent key={model.cid} model={model} />`
