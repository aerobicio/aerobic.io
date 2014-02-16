describe "app.controllers.GarminUploadController", ->
  beforeEach ->
    @container = $("""
      <div id="GarminUpload"></div>
    """).appendTo "body"

    @garminUnlockStub = sinon.stub(Garmin.prototype, 'unlock')
    Garmin.prototype.devices = ->
      deferred = Q.defer()
      model =
        date: -> new Date
      deferred.resolve [sinon.mock(model)]
      deferred.promise

    @initializeViewsSpy = sinon.spy(app.controllers.GarminUploadController.prototype, 'initializeViews')
    @controller = new app.controllers.GarminUploadController(
      el: @container
      garmin:
        testMode: true
    )
    @controller.workoutsComponent = setState: -> return
    @controller.workoutsCollection.fetch = -> return
    @garminUploadComponentStub = sinon.stub(@controller.garminUploadComponent, 'setState')
    @workoutsCollectionStub = sinon.stub(@controller.workoutsCollection, 'fetch').returns(Q.defer().promise)

  afterEach ->
    @controller = null
    @container.remove()
    @garminUnlockStub.restore()
    @initializeViewsSpy.restore()
    @garminUploadComponentStub.restore()

  it "calls initializeViews immediately", ->
    chai.expect(@initializeViewsSpy.calledOnce).to.be.true

  describe "#initializeViews", ->
    beforeEach ->
      @componentStub = sinon.stub()
      @renderComponentStub = sinon.stub(React, 'renderComponent')
      @garminUploadComponentStub = sinon.stub(app.components, 'GarminUploadComponent').returns @componentStub
      @controller.initializeViews()

    afterEach ->
      @garminUploadComponentStub.restore()
      @renderComponentStub.restore()

    describe "GarminUploadComponent", ->
      it "creates the component", ->
        chai.expect(@controller.garminUploadComponent).to.be.a.function

      it "renders the component", ->
        chai.expect(@renderComponentStub.calledWith(
          @componentStub
          document.getElementById("GarminUpload")
        )).to.be.true

  describe "#onDeviceSelect", ->
    it "lets the workouts component know that a device is selected", ->
      device = get: -> return
      @controller.onDeviceSelect(device)
      chai.expect(@garminUploadComponentStub.calledWith(hasDeviceSelected: true)).to.be.true

    it "fetches workouts", ->
      device = get: -> return
      @controller.onDeviceSelect(device)
      chai.expect(@workoutsCollectionStub.calledWith(device)).to.be.true

  describe "#onDeviceUnselect", ->
    it "resets the progressModel", ->
      @controller.progressModel.set
        percent: 69
        message: "derp"
      @controller.onDeviceUnselect()
      chai.expect(@controller.progressModel.get('percent')).to.equal -1
      chai.expect(@controller.progressModel.get('message')).to.equal ""

    it "lets the workouts component know that no devices are selected", ->
      @controller.onDeviceUnselect()
      chai.expect(@garminUploadComponentStub.calledWith(hasDeviceSelected: false)).to.be.true

    it "empties the workoutsCollection", ->
      @controller.workoutsCollection.reset([
        derp: 'test'
        date: -> new Date
        id: 1
        device:
          id: 2
      ])
      @controller.onDeviceUnselect()
      chai.expect(@controller.workoutsCollection.length).to.equal 0

  describe "#_updateWorkoutCollectionWithExistingWorkouts", ->
    beforeEach ->
      @workout1 = new app.models.WorkoutModel id: 1, name: 'workout1', device: id: 2
      @workout1.date = -> new Date
      @workout2 = new app.models.WorkoutModel id: 2, name: 'workout2', device: id: 2
      @workout2.date = -> new Date
      @workout3 = new app.models.WorkoutModel id: 3, name: 'workout3', device: id: 2
      @workout3.date = -> new Date
      @existingWorkout = new app.models.WorkoutModel id: 2, device_workout_id: 2, name: 'existingWorkout', device: id: 2
      @existingWorkout.date = -> new Date
      @controller.workoutsCollection.reset([@workout1, @workout2, @workout3])
      @controller.exitstingWorkoutsCollection = new app.collections.WorkoutsCollection []
      @controller.exitstingWorkoutsCollection.getWorkoutsForDeviceId = -> return
      @getWorkoutsForDeviceIdStub = sinon.stub(@controller.exitstingWorkoutsCollection, 'getWorkoutsForDeviceId')

    it "removes workouts that are already uploaded from the workoutsCollection", ->
      @getWorkoutsForDeviceIdStub.withArgs(99).returns([@existingWorkout])
      @controller._updateWorkoutCollectionWithExistingWorkouts(99)
      chai.expect(@controller.workoutsCollection.length).to.equal 3
      chai.expect(@controller.workoutsCollection.get(1).get('name')).to.equal 'workout1'
      chai.expect(@controller.workoutsCollection.get(2).get('name')).to.equal 'existingWorkout'
      chai.expect(@controller.workoutsCollection.get(3).get('name')).to.equal 'workout3'

  describe "#_updateProgress", ->
    beforeEach ->
      @progressModelSetSpy = sinon.spy(@controller.progressModel, 'set')

    describe "progress percentage has changed", ->
      it "updates the progressModel", ->
        @controller._updateProgress(percent: 50)
        chai.expect(@progressModelSetSpy.calledWith(percent: 50)).to.be.true

    describe "progress percentage has not changed", ->
      it "does nothing", ->
        @controller._updateProgress(percent: 50)
        @controller._updateProgress(percent: 50)
        chai.expect(@progressModelSetSpy.calledOnce).to.be.true
