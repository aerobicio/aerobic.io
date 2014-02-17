###* @jsx React.DOM ###

@app.components.WorkoutListComponent = React.createClass
  displayName: 'app.components.WorkoutListComponent'
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.WorkoutsCollection).isRequired

  render: ->
    workoutNodes = @workoutNodesForDevice(@props.collection)

    `<ol className="workouts__list">
      {workoutNodes}
    </ol>`

  workoutNodesForDevice: (workoutCollection) ->
    if workoutCollection.length
      workoutCollection.map @workoutNodeForWorkout
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
