@app.controllers.GarminUploadController = class GarminUploadController extends app.controllers.ViewController
  el: "#GarminUploadController"

  initialize: (options) ->
    @options = options
    @progressModel = new app.models.ProgressModel
    @devicesCollection = new app.collections.DevicesCollection [], garminDelegate: new Garmin
    @workoutsCollection = new app.collections.WorkoutsCollection []
    @exitstingWorkoutsCollection = new app.collections.WorkoutsCollection []
    @exitstingWorkoutsCollection.reset(@options.existingMemberWorkouts)

    @initializeUI()

  initializeUI: ->
    @deviceListComponent = app.components.DeviceListComponent(
      collection: @devicesCollection
      deviceSelectedDelegate: @deviceSelected
      deviceUnselectedDelegate: @deviceUnselected
      progressModel: @progressModel
    )
    @workoutsComponent = app.components.WorkoutsComponent(
      collection: @workoutsCollection
      uploadPath: @options.uploadPath
    )
    React.renderComponent(@deviceListComponent, document.getElementById("DevicesList"))
    React.renderComponent(@workoutsComponent, document.getElementById("Workouts"))

  deviceSelected: (device) =>
    @workoutsComponent.setState(hasDeviceSelected: true)
    @workoutsCollection.fetch(device)
      .progress(@updateProgress)
      .then(@updateWorkoutCollectionWithExistingWorkouts.bind(@, device.get('id')))

  deviceUnselected: =>
    @progressModel.set(@progressModel.defaults)
    @workoutsComponent.setState(hasDeviceSelected: false)
    @workoutsCollection.reset([])

  updateWorkoutCollectionWithExistingWorkouts: (deviceId) ->
    workoutsCollectionClone = @workoutsCollection.clone()
    @exitstingWorkoutsCollection.getWorkoutsForDeviceId(deviceId).map (existingWorkout) =>
      workout = workoutsCollectionClone.get(existingWorkout.get('device_workout_id'))
      workoutIndex = workoutsCollectionClone.indexOf(workout) - 1
      workoutsCollectionClone.remove(workout)
      workoutsCollectionClone.add(existingWorkout, at: workoutIndex)

    @workoutsCollection.reset(workoutsCollectionClone.toJSON())

  updateProgress: (progress) =>
    unless progress.percent is @_lastProgressPercentage
      console.log 'updated progress'
      @progressModel.set(progress)
      @_lastProgressPercentage = progress.percent
