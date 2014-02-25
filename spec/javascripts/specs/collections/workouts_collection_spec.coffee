describe "app.collections.WorkoutsCollection", ->
  beforeEach ->
    @collection = new app.collections.WorkoutsCollection [], uploadPath: '/velociraptor/butts/'
    @collection.queueUploadRequests = false
    @onUploadStartedSpy = sinon.spy(@collection, 'onUploadStarted')
    @onUploadDoneSpy = sinon.spy(@collection, 'onUploadDone')
    @onUploadFailSpy = sinon.spy(@collection, 'onUploadFail')

  afterEach ->
    @collection = null

  describe "#model", ->
    describe "an existing workout", ->
      it "creates an ExistingWorkoutModel", ->
        model = @collection.model(created_at: new Date)
        chai.expect(model).to.be.an.instanceof(app.models.ExistingWorkoutModel)

    describe "a new workout", ->
      it "creates a WorkoutModel", ->
        model = @collection.model(
          id: 1,
          device:
            id: 2
        )
        chai.expect(model).to.be.an.instanceof(app.models.WorkoutModel)

  describe "#fetch", ->
    beforeEach ->
      @promise = Q.defer()
      @deviceStub = sinon.stub(getActivities: -> [{date: new Date}])
      @deviceStub.getActivities.returns(@promise.promise)

    it "empties the collection", ->
      @collection.add foo: 'bar', id: 1, device: id: 2
      @collection.fetch(@deviceStub)
      chai.expect(@collection.length).to.equal 0

    it "resets the collection with the returned workouts", (done) ->
      w1 = new app.models.WorkoutModel(date: new Date, device: id: 1, canReadFITActivities: true)
      w2 = new app.models.WorkoutModel(date: new Date, device: id: 2, canReadFITActivities: true)
      w3 = new app.models.WorkoutModel(date: new Date, device: id: 3, canReadFITActivities: true)
      promise = @collection.fetch(@deviceStub)
      promise.done =>
        chai.expect(@collection.length).to.equal 3
        chai.expect(@collection.at(0)).to.equal w1
        chai.expect(@collection.at(1)).to.equal w2
        chai.expect(@collection.at(2)).to.equal w3
        done()
      @promise.resolve([w1, w2, w3])

  describe "#selectAll", ->
    it "selects all the workouts in the collection", ->
      w1 = new Backbone.Model
      w1.date = -> new Date
      w2 = new Backbone.Model
      w2.date = -> new Date
      @collection.add([w1, w2])
      @collection.selectAll()
      chai.expect(@collection.at(0).get('checked')).to.be.true
      chai.expect(@collection.at(1).get('checked')).to.be.true

  describe "#selectedWorkouts", ->
    it "returns all the selected workouts", ->
      w1 = new Backbone.Model
      w1.date = -> new Date
      w2 = new Backbone.Model checked: true
      w2.date = -> new Date
      @collection.add([w1, w2])
      chai.expect(@collection.selectedWorkouts()[0]).to.equal w2

  describe "#getSelectedWorkoutsCount", ->
    it "returns the number of workouts that are selected", ->
      w1 = new Backbone.Model
      w1.date = -> new Date
      w2 = new Backbone.Model checked: true
      w2.date = -> new Date
      @collection.add([w1, w2])
      chai.expect(@collection.getSelectedWorkoutsCount()).to.equal 1

  describe "#getWorkoutsForDeviceId", ->
    it "returns all the workouts that belong to the device with the given id", ->
      w1 = new Backbone.Model
      w1.date = -> new Date
      w2 = new Backbone.Model device_id: 99
      w2.date = -> new Date
      @collection.add([w1, w2])
      chai.expect(@collection.getWorkoutsForDeviceId(99)[0]).to.equal w2

  describe "#uploadSelectedWorkouts", ->
    beforeEach ->
      @collection.selectedWorkouts = sinon.stub()
      @w1 = new Backbone.Model
      @w1DataPromise = Q.defer()
      @w1.data = => @w1DataPromise.promise
      @w1.date = -> new Date
      @w2 = new Backbone.Model
      @w2DataPromise = Q.defer()
      @w2.data = => @w2DataPromise.promise
      @w2.date = -> new Date
      @w3 = new Backbone.Model
      @w3DataPromise = Q.defer()
      @w3.data = => @w3DataPromise.promise
      @w3.date = -> new Date
      @w1Spy = sinon.spy(@w1, 'data')
      @w2Spy = sinon.spy(@w2, 'data')
      @w3Spy = sinon.spy(@w3, 'data')

    afterEach ->
      @w1Spy.restore()
      @w2Spy.restore()
      @w3Spy.restore()

    it "loads the data for each workout", ->
      @collection.selectedWorkouts.returns([@w1, @w2, @w3])
      @collection.uploadSelectedWorkouts()
      chai.expect(@w1Spy.calledOnce).to.be.true
      chai.expect(@w2Spy.calledOnce).to.be.true
      chai.expect(@w3Spy.calledOnce).to.be.true

    it "uploads the data for each workout", (done) ->
      @collection.uploadWorkout = sinon.stub()
      data = 'I am data!'
      @collection.selectedWorkouts.returns([@w1])
      @collection.uploadSelectedWorkouts()
      @w1DataPromise.promise.then =>
        chai.expect(@collection.uploadWorkout.calledWith(@w1, data)).to.be.true
        done()
      @w1DataPromise.resolve(data)

  describe "#uploadWorkout", ->
    beforeEach ->
      @workout = new Backbone.Model
      @server = sinon.fakeServer.create()
      sinon.stub(@collection, 'workoutData').returns(herp: 'derp')

    it "sets the upload started state", ->
      @collection.uploadWorkout(@workout, @data)
      chai.expect(@onUploadStartedSpy.calledOnce).to.be.true
      chai.expect(@workout.get('status')).to.equal "uploading"

    describe "success", ->
      beforeEach ->
        @responseData =
          id: 1
          device: id: 2
        @server.respondWith(
          "POST", "/velociraptor/butts/",
          [200, {"Content-Type": "application/json"}, JSON.stringify(@responseData)]
        )

      it "sets the upload done state", (done) ->
        promise = @collection.uploadWorkout(@workout)
        promise.always (data) =>
          workout = @collection.models[@collection.indexOf(@workout)]
          chai.expect(workout.get('status')).to.equal "uploaded"
          done()
        @server.respond()

    describe "failure", ->
      beforeEach ->
        @server.respondWith(
          "POST", "/velociraptor/butts/",
          [500, {"Content-Type": "application/json"}, 'derp']
        )

      it "sets the upload failed state", (done) ->
        promise = @collection.uploadWorkout(@workout)
        promise.always =>
          chai.expect(@workout.get('status')).to.equal "failed"
          done()
        @server.respond()

  describe "#workoutData", ->
    beforeEach ->
      @workout = get: -> return
      @workoutGetStub = sinon.stub(@workout, 'get')
      @workoutGetStub.withArgs('device').returns(new app.models.DeviceModel({id: 1, format: 'fit'}))
      @workoutGetStub.withArgs('id').returns(2)
      @workoutGetStub.withArgs('format').returns('fit')
      @data = "I am data."

    it "retuns a object with the workout data", ->
      workoutData = @collection.workoutData(@workout, @data)
      chai.expect(workoutData.workout_data).to.equal @data
      chai.expect(workoutData.activity_type).to.equal 'fit'
      chai.expect(workoutData.device_id).to.equal 1
      chai.expect(workoutData.device_workout_id).to.equal 2
