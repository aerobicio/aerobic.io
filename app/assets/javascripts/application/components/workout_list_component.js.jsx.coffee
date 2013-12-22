###* @jsx React.DOM ###

@app.components.WorkoutListComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  render: ->
    workoutNodes = @workoutNodesForDevice(@props.collection)
    `<ol>
      {workoutNodes}
    </ol>`

  workoutNodesForDevice: (workoutCollection) ->
    workoutCollection.map (workout) =>
      app.components.WorkoutComponent(model: workout)
