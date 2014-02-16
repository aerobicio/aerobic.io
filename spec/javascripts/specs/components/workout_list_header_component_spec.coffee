describe "app.components.WorkoutListHeaderComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new app.collections.WorkoutsCollection
    @collection.getSelectedWorkoutsCount = sinon.stub()
    @onClickHandler = sinon.spy()
    @component = app.components.WorkoutListHeaderComponent(
      collection: @collection
      onClickHandler: @onClickHandler
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

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
