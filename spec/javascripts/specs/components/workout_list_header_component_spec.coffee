describe "app.components.WorkoutListHeaderComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new Backbone.Collection
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @onClick = sinon.spy()
    @component = app.components.WorkoutListHeaderComponent(
      collection: @collection
      onClick: @onClick
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountAndReleaseReactRootNode(@fixtureEl)
    @fixture.remove()

  describe "#onClick", ->
    beforeEach ->
      @event =
        preventDefault: -> return
      @preventDefaultSpy = sinon.spy(@event, 'preventDefault')

    it "prevents default", ->
      @component.onClick(@event)
      chai.expect(@preventDefaultSpy.calledOnce).to.be.true

    it "calls the onClick handler property", ->
      @component.onClick(@event)
      chai.expect(@onClick.calledOnce).to.be.true

    it "passes the event into the onClick handler property", ->
      @component.onClick(@event)
      chai.expect(@onClick.calledWith(@event)).to.be.true

  describe "#getSelectedWorkoutsCount", ->
    beforeEach ->
      @collection.getSelectedWorkoutsCount.returns(5)

    it "returns the number of selected workouts", ->
      chai.expect(@component.getSelectedWorkoutsCount()).to.equal 5

  describe "#getSelectedWorkouts", ->
    describe "no workouts selected", ->
      beforeEach ->
        @collection.getSelectedWorkoutsCount.returns(0)

      it "returns nothing", ->
        chai.expect(@component.getSelectedWorkouts()).to.equal ""

    describe "with workouts selected", ->
      beforeEach ->
        @collection.getSelectedWorkoutsCount.returns(5)

      it "returns the formatted selected workout count", ->
        chai.expect(@component.getSelectedWorkouts()).to.equal "(5)"

  describe "#getUploadButtonDisabled", ->
    describe "with workouts selected", ->
      beforeEach ->
        @collection.getSelectedWorkoutsCount.returns(5)

      it "returns false if the count is positive", ->
        @component.getUploadButtonDisabled()
        chai.expect(@component.getUploadButtonDisabled()).to.be.false

    describe "no workouts selected", ->
      beforeEach ->
        @collection.getSelectedWorkoutsCount.returns(0)

      it "returns true if the count is not positive", ->
        @component.getUploadButtonDisabled()
        chai.expect(@component.getUploadButtonDisabled()).to.be.true
