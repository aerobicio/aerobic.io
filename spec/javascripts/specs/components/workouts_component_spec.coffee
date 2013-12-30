describe "app.components.WorkoutsComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new Backbone.Collection
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @collection.selectedWorkouts = sinon.stub()
    @onClickDelegate = sinon.stub()
    @component = app.components.WorkoutsComponent(
      collection: @collection
      onClick: @onClickDelegate
      uploadPath: '/velociraptor/butts/'
    )
    @_uploadStartedSpy = sinon.stub(@component, '_uploadStarted')
    @_uploadDoneSpy = sinon.stub(@component, '_uploadDone')
    @_uploadFailSpy = sinon.stub(@component, '_uploadFail')
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#getInitialState", ->
    it "sets the initial state", ->
      chai.expect(@component.state.hasDeviceSelected).to.be.false

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "workouts"

    it "has a selected class if the component state is selected", ->
      @component.setState(hasDeviceSelected: true)
      chai.expect(@component.classes()).to.have.string "has-device-selected"

  describe "#onClick", ->
    beforeEach ->
      @uploadSelectedWorkoutsStub = sinon.stub(@component, 'uploadSelectedWorkouts')
      event = preventDefault: -> return
      @preventDefaultSpy = sinon.spy(event, 'preventDefault')
      @component.onClick(event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "calls the device selected delegate method", ->
      chai.expect(@uploadSelectedWorkoutsStub.calledOnce).to.be.true

  describe "#uploadSelectedWorkouts", ->
    beforeEach ->
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
      @component.uploadSelectedWorkouts()
      chai.expect(@w1Spy.calledOnce).to.be.true
      chai.expect(@w2Spy.calledOnce).to.be.true
      chai.expect(@w3Spy.calledOnce).to.be.true

    it "uploads the data for each workout", (done) ->
      @component.uploadWorkout = sinon.stub()
      data = 'I am data!'
      @collection.selectedWorkouts.returns([@w1])
      @component.uploadSelectedWorkouts()
      @w1DataPromise.promise.then =>
        chai.expect(@component.uploadWorkout.calledWith(@w1, data)).to.be.true
        done()
      @w1DataPromise.resolve(data)

  describe "#uploadWorkout", ->
    beforeEach ->
      @workout = new Backbone.Model
      @server = sinon.fakeServer.create()
      @component.setState(queueUploadRequests: false)
      sinon.stub(@component, 'workoutData').returns(herp: 'derp')

    it "sets the upload started state", ->
      @component.uploadWorkout(@workout)
      chai.expect(@workout.get('status')).to.equal "uploading"

    it "makes the async request"

    describe "success", ->
      beforeEach ->
        @server.respondWith(
          "POST", "/velociraptor/butts/",
          [200, {"Content-Type": "application/json"}, "{}"]
        )

      it "sets the upload done state", (done) ->
        promise = @component.uploadWorkout(@workout)
        promise.always (data) =>
          chai.expect(@workout.get('status')).to.equal "uploaded"
          done()
        @server.respond()

    describe "failure", ->
      beforeEach ->
        @server.respondWith(
          "POST", "/velociraptor/butts/",
          [500, {"Content-Type": "application/json"}, 'derp']
        )

      it "sets the upload failed state", (done) ->
        promise = @component.uploadWorkout(@workout)
        promise.always =>
          chai.expect(@workout.get('status')).to.equal "failed"
          done()
        @server.respond()

  describe "#workoutData", ->
    beforeEach ->
      @workout = get: -> return
      @workoutGetStub = sinon.stub(@workout, 'get')
      @workoutGetStub.withArgs('device').returns(id: 1)
      @workoutGetStub.withArgs('id').returns(2)
      @data = "I am data."

    it "retuns a object with the workout data", ->
      workoutData = @component.workoutData(@workout, @data)
      chai.expect(workoutData.activity).to.equal @data
      chai.expect(workoutData.device_id).to.equal 1
      chai.expect(workoutData.device_workout_id).to.equal 2
