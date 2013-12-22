@app.controllers.GarminUploadController = class GarminUploadController extends app.controllers.ViewController
  el: "#GarminUploadController"

  initialize: (options) ->
    @options = options

    @progressModel = new app.models.ProgressModel
    @devicesCollection = new app.collections.DevicesCollection [], garminDelegate: new Garmin
    @workoutsCollection = new app.collections.WorkoutsCollection [], updateProgressDelegate: @updateProgress
    # @exitstingWorkoutsCollection = new app.collections.WorkoutsCollection
    # @exitstingWorkoutsCollection.reset(@options.existingMemberWorkouts)

    console.log @options.existingMemberWorkouts

    deviceListComponent = app.components.DeviceListComponent(
      collection: @devicesCollection
      getWorkoutsDelegate: @getWorkoutsForDevice
    )
    workoutsComponent = app.components.WorkoutsComponent(
      collection: @workoutsCollection
      progressModel: @progressModel
    )

    React.renderComponent(deviceListComponent, document.getElementById("DevicesList"))
    React.renderComponent(workoutsComponent, document.getElementById("Workouts"))

  getWorkoutsForDevice: (device) =>
    @workoutsCollection.fetch(device)

  updateProgress: (progress) =>
    unless progress.percent is @_lastProgressPercentage
      @progressModel.set(progress)
      @_lastProgressPercentage = progress.percent
