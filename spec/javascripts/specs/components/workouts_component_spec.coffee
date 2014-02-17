describe "app.components.WorkoutsComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new app.collections.WorkoutsCollection
    @collection.uploadSelectedWorkouts = sinon.stub()
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @progressModel = new app.models.ProgressModel
    @hasDeviceSelected = true
    @component = app.components.WorkoutsComponent(
      collection: @collection
      progressModel: @progressModel
      hasDeviceSelected: @hasDeviceSelected
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#getInitialState", ->
    it "has some initial state", ->
      chai.expect(@component.state.deviceHasFinishedLoading).to.be.false

  describe "#componentDidMount", ->
    it "sets the 'deviceHasFinishedLoading' state to true when loading is complete", ->
      @progressModel.set(percent: 100)
      chai.expect(@component.state.deviceHasFinishedLoading).to.be.true

    it "sets the 'deviceHasFinishedLoading' state to false when there is no progress", ->
      @component.setState(deviceHasFinishedLoading: true)
      @progressModel.clear(silent: true).set(@progressModel.defaults)
      chai.expect(@component.state.deviceHasFinishedLoading).to.be.false

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "workouts"

  describe "#onClick", ->
    beforeEach ->
      event = preventDefault: -> return
      @preventDefaultSpy = sinon.spy(event, 'preventDefault')
      @component.onClick(event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "calls the device selected delegate method", ->
      chai.expect(@collection.uploadSelectedWorkouts.calledOnce).to.be.true
