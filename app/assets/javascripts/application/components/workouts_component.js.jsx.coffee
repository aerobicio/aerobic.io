###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]

  getBackboneModels: ->
    [@props.collection]

  getInitialState: ->
    queueUploadRequests: true
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
    @uploadSelectedWorkouts()

  selectedWorkouts: ->
    @props.collection.selectedWorkouts()

  uploadSelectedWorkouts: ->
    @selectedWorkouts().map (workout) =>
      workout.data().then (data) =>
        @uploadWorkout(workout, data)

  uploadWorkout: (workout, data) ->
    @_uploadStarted(workout)
    request = jQuery.ajax
      type: "POST"
      url: @props.uploadPath
      data: @workoutData(workout, data)
      dataType: 'json'
      queue: @state.queueUploadRequests
    request.done (data) => @_uploadDone(workout)
    request.fail (data) => @_uploadFail(workout)
    request

  workoutData: (workout, data) ->
    activity: data
    device_id: workout.get('device').id
    device_workout_id: workout.get('id')
    uuid: workout.get('uuid')

  _uploadStarted: (workout) ->
    workout.set(status: 'uploading')

  _uploadDone: (workout) ->
    workout.set(status: 'uploaded')

  _uploadFail: (workout) ->
    workout.set(status: 'failed')
