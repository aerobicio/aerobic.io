###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  getInitialState: ->
    hasDeviceSelected: false

  render: ->
    WorkoutListHeaderComponent = app.components.WorkoutListHeaderComponent
    WorkoutListComponent = app.components.WorkoutListComponent
    collection = @props.collection

    `<div className={this.classes()}>
      <WorkoutListHeaderComponent collection={collection} onClick={this.onClick} />
      <WorkoutListComponent collection={collection} />
    </div>`

  classes: ->
    React.addons.classSet
      "workouts": true
      "has-device-selected": @state.hasDeviceSelected

  onClick: (event) ->
    @uploadSelectedWorkouts()

  uploadSelectedWorkouts: ->
    @props.collection.selectedWorkouts().map (workout) =>
      workout.data().then (data) =>
        workout.set(status: 'uploading')
        request = @uploadWorkout(workout, data)
        request.done -> workout.set(status: 'uploaded')
        request.fail -> workout.set(status: 'failed')

  uploadWorkout: (workout, data) ->
    jQuery.ajax
      type: "POST"
      url: @props.uploadPath
      data:
        activity: data
        device_id: workout.get('device').id
        device_workout_id: workout.get('id')
      dataType: 'json'
      queue: true
