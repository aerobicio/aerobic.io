@app.controllers.GarminUploadController = class GarminUploadController extends app.controllers.ViewController
  el: "#GarminUploadController"

  initialize: (options) ->
    @options = _(options).defaults {}

    @garmin = new Garmin @options.garmin
    @garminIsInstalled = @garmin.isInstalled()

    @progressModel = new app.models.ProgressModel
    @devicesCollection = new app.collections.DevicesCollection [], garminDelegate: @garmin
    @workoutsCollection = new app.collections.WorkoutsCollection [], uploadPath: @options.uploadPath
    @exitstingWorkoutsCollection = new app.collections.WorkoutsCollection []
    @exitstingWorkoutsCollection.reset(@options.existingMemberWorkouts)

    @initializeUI()

    if @garminIsInstalled
      @fetchDevices()

  fetchDevices: ->
    promise = @devicesCollection.fetch()
    promise.then(=> @deviceListComponent.setState(isLoading: false))
    promise

  initializeUI: ->
    @deviceListComponent = app.components.DeviceListComponent(
      collection: @devicesCollection
      deviceSelectedDelegate: @deviceSelected
      deviceUnselectedDelegate: @deviceUnselected
      progressModel: @progressModel
      pluginIsInstalled: @garminIsInstalled
    )
    @workoutsComponent = app.components.WorkoutsComponent(
      collection: @workoutsCollection
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
      workoutIndex = workoutsCollectionClone.indexOf(workout)
      workoutsCollectionClone.remove(workout)
      workoutsCollectionClone.add(existingWorkout, at: workoutIndex)

    @workoutsCollection.reset(workoutsCollectionClone.models)

  updateProgress: (progress) =>
    unless progress.percent is @_lastProgressPercentage
      @progressModel.set(progress)
      @_lastProgressPercentage = progress.percent
