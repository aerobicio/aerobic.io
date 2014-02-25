describe "app.components.WorkoutsComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new app.collections.WorkoutsCollection
    @collection.uploadSelectedWorkouts = sinon.stub()
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @progressModel = new app.models.ProgressModel
    @hasDeviceSelected = true
    @deviceHasFinishedLoading = true
    @component = app.components.WorkoutsComponent(
      collection: @collection
      progressModel: @progressModel
      hasDeviceSelected: @hasDeviceSelected
      deviceHasFinishedLoading: @deviceHasFinishedLoading
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

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
