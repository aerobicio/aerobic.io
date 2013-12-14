@app.controllers.GarminUploadController = class GarminUploadController extends app.controllers.BoundViewController
  el: "#GarminUploadController"

  initialize: (options) ->
    @options = options

    @progressModel = new app.models.ProgressModel

    @devicesCollection = new app.collections.DevicesCollection [], garminDelegate: new Garmin
    @workoutsCollection = new app.collections.WorkoutsCollection [], updateProgressDelegate: @updateProgress
    @exitstingWorkoutsCollection = new app.collections.WorkoutsCollection
    # @exitstingWorkoutsCollection.reset(@options.existingMemberWorkouts)

    console.log @options.existingMemberWorkouts

    @devicesView = new app.views.DevicesView
      getWorkoutsDelegate: @getWorkoutsForDevice
      bindings:
        devices: @devicesCollection

    @uploadWorkoutListView = new app.views.UploadWorkoutListView
      onClickDelegate: @uploadSelectedWorkouts
      bindings:
        workouts: @workoutsCollection
        progress: @progressModel

  getWorkoutsForDevice: (device) =>
    @workoutsCollection.fetch(device)

  uploadSelectedWorkouts: =>
    workouts = @workoutsCollection.selectedWorkouts()
    _(workouts).map (workout) =>
      workout.getData().then (data) =>
        console.log workout
        workout.set(status: 'uploading')
        request = $.ajax(
          type: "POST"
          url: @options.uploadPath
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

  updateProgress: (progress) =>
    if progress.percent != @lastProgressPercentage
      @progressModel.set(progress)
      @lastProgressPercentage = progress.percent
