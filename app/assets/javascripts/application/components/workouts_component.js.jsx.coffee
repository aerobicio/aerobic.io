###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  render: ->
    WorkoutListHeaderComponent = app.components.WorkoutListHeaderComponent
    WorkoutListComponent = app.components.WorkoutListComponent
    collection = @props.collection
    progressModel = @props.progressModel

    `<div>
      <WorkoutListHeaderComponent collection={collection}
                                  progressModel={progressModel}
                                  onClick={this.onClick} />
      <WorkoutListComponent collection={collection} />
    </div>`

  onClick: (event) ->
    @uploadSelectedWorkouts()

  uploadSelectedWorkouts: ->
    workouts = @props.collection.selectedWorkouts()
    _(workouts).map (workout) ->
      workout.data().then (data) ->
        workout.set(status: 'uploading')
        request = $.ajax(
          type: "POST"
          url: "/upload"
          data:
            activity: data
            device_workout_id: workout.get('id')
          dataType: 'json'
          queue: true
        )
        request.done ->
          workout.set(status: 'uploaded')
        request.fail ->
          workout.set(status: 'failed')
