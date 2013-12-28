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

  afterEach ->
    @controller = null
    @container.remove()
    @initializeUIStub.restore()

  it "initializes the UI", ->
    chai.expect(@initializeUIStub.calledOnce).to.be.true

  describe "#deviceSelected"

  describe "#deviceUnselected"

  describe "#updateWorkoutCollectionWithExistingWorkouts"

  describe "#updateProgress"
