describe "app.controllers.GarminUploadController", ->
  beforeEach ->
    @container = $("""
      <div>
        <div id="DevicesList"></div>
        <div id="Workouts"></div>
      </div>
    """).appendTo "body"
    @initializeUIStub = sinon.stub(app.controllers.GarminUploadController.prototype, 'initializeUI')
    @controller = new app.controllers.GarminUploadController(el: @container)
    @controller.workoutsComponent = setState: -> return
    @controller.workoutsCollection.fetch = -> return
    @workoutsComponentSetStateStub = sinon.stub(@controller.workoutsComponent, 'setState')
    @workoutsCollectionStub = sinon.stub(@controller.workoutsCollection, 'fetch').returns(Q.defer().promise)

  afterEach ->
    @controller = null
    @container.remove()
    @initializeUIStub.restore()
    @workoutsComponentSetStateStub.restore()

  it "initializes the UI", ->
    chai.expect(@initializeUIStub.calledOnce).to.be.true

  describe "#deviceSelected", ->
    it "lets the workouts component know that a device is selected", ->
      device = get: -> return
      @controller.deviceSelected(device)
      chai.expect(@workoutsComponentSetStateStub.calledWith(hasDeviceSelected: true)).to.be.true

    it "fetches workouts", ->
      device = get: -> return
      @controller.deviceSelected(device)
      chai.expect(@workoutsCollectionStub.calledWith(device)).to.be.true

  describe "#deviceUnselected", ->
    it "resets the progressModel", ->
      @controller.progressModel.set
        percent: 69
        message: "derp"
      @controller.deviceUnselected()
      chai.expect(@controller.progressModel.get('percent')).to.equal 0
      chai.expect(@controller.progressModel.get('message')).to.equal ""

    it "lets the workouts component know that no devices are selected", ->
      @controller.deviceUnselected()
      chai.expect(@workoutsComponentSetStateStub.calledWith(hasDeviceSelected: false)).to.be.true

    it "empties the workoutsCollection", ->
      @controller.workoutsCollection.reset([derp: 'test'])
      @controller.deviceUnselected()
      chai.expect(@controller.workoutsCollection.length).to.equal 0

  describe "#updateWorkoutCollectionWithExistingWorkouts", ->
    beforeEach ->
      @workout1 = new app.models.WorkoutModel id: 1, name: 'workout1'
      @workout2 = new app.models.WorkoutModel id: 2, name: 'workout2'
      @workout3 = new app.models.WorkoutModel id: 3, name: 'workout3'
      @existingWorkout = new app.models.WorkoutModel id: 2, device_workout_id: 2, name: 'existingWorkout'
      @controller.workoutsCollection.reset([@workout1, @workout2, @workout3])
      @controller.exitstingWorkoutsCollection = new app.collections.WorkoutsCollection []
      @controller.exitstingWorkoutsCollection.getWorkoutsForDeviceId = -> return
      @getWorkoutsForDeviceIdStub = sinon.stub(@controller.exitstingWorkoutsCollection, 'getWorkoutsForDeviceId')

    it "removes workouts that are already uploaded from the workoutsCollection", ->
      @getWorkoutsForDeviceIdStub.withArgs(99).returns(new app.collections.WorkoutsCollection [@existingWorkout])
      @controller.updateWorkoutCollectionWithExistingWorkouts(99)
      chai.expect(@controller.workoutsCollection.length).to.equal 3
      chai.expect(@controller.workoutsCollection.get(1).get('name')).to.equal 'workout1'
      chai.expect(@controller.workoutsCollection.get(2).get('name')).to.equal 'existingWorkout'
      chai.expect(@controller.workoutsCollection.get(3).get('name')).to.equal 'workout3'

  describe "#updateProgress", ->
    beforeEach ->
      @progressModelSetSpy = sinon.spy(@controller.progressModel, 'set')

    describe "progress percentage has changed", ->
      it "updates the progressModel", ->
        @controller.updateProgress(percent: 50)
        chai.expect(@progressModelSetSpy.calledWith(percent: 50)).to.be.true

    describe "progress percentage has not changed", ->
      it "does nothing", ->
        @controller.updateProgress(percent: 50)
        @controller.updateProgress(percent: 50)
        chai.expect(@progressModelSetSpy.calledOnce).to.be.true
