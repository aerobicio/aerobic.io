describe "app.collections.WorkoutsCollection", ->
  beforeEach ->
    @collection = new app.collections.WorkoutsCollection [], garminDelegate: @garminDelegateStub

  afterEach ->
    @collection = null

  describe "#model", ->
    describe "an existing workout", ->
      it "creates an ExistingWorkoutModel", ->
        model = @collection.model(created_at: new Date)
        chai.expect(model).to.be.an.instanceof(app.models.ExistingWorkoutModel)

    describe "a new workout", ->
      it "creates a WorkoutModel", ->
        model = @collection.model({})
        chai.expect(model).to.be.an.instanceof(app.models.WorkoutModel)

  describe "#fetch", ->
    beforeEach ->
      @promise = Q.defer()
      @deviceStub = sinon.stub(getActivities: -> return)
      @deviceStub.getActivities.returns(@promise.promise)

    it "empties the collection", ->
      @collection.add foo: 'bar'
      @collection.fetch(@deviceStub)
      chai.expect(@collection.length).to.equal 0

    it "resets the collection with the returned workouts", (done) ->
      w1 = new Backbone.Model
      w2 = new Backbone.Model
      w3 = new Backbone.Model
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
