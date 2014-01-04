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
    if workoutCollection.length
      workoutCollection.map (workout) =>
        @workoutNodeForWorkout(workout)
    else
      `<li>We couldn’t find any workouts — better go training!</li>`

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
