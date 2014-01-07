describe "app.components.WorkoutsComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new Backbone.Collection
    @collection.uploadSelectedWorkouts = sinon.stub()
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @onClickDelegate = sinon.stub()
    @component = app.components.WorkoutsComponent(
      collection: @collection
      onClick: @onClickDelegate
    )
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
      event = preventDefault: -> return
      @preventDefaultSpy = sinon.spy(event, 'preventDefault')
      @component.onClick(event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "calls the device selected delegate method", ->
      chai.expect(@collection.uploadSelectedWorkouts.calledOnce).to.be.true
