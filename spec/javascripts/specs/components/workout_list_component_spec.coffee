describe "app.components.WorkoutListComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @collection = new Backbone.Collection
    @component = app.components.WorkoutListComponent(collection: @collection)
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#workoutNodesForDevice", ->
    beforeEach ->
      @workoutNodeForWorkout = sinon.stub(@component, 'workoutNodeForWorkout').returns(sinon.stub())

    it "creates a workout node for each workout in the collection", ->
      workoutsCollection = new Backbone.Collection [sinon.stub(), sinon.stub(), sinon.stub()]
      @component.workoutNodesForDevice(workoutsCollection)
      chai.expect(@workoutNodeForWorkout.calledThrice).to.be.true

  describe "#workoutNodeForWorkout", ->
    beforeEach ->
      @existingWorkoutNodeSpy = sinon.spy(@component, 'existingWorkoutNode')
      @workoutNodeSpy = sinon.spy(@component, 'workoutNode')

    afterEach ->
      @existingWorkoutNodeSpy.restore()
      @workoutNodeSpy.restore()

    describe "for an existing workout", ->
      beforeEach ->
        @model = new app.models.ExistingWorkoutModel
          name: "Velociraptor"
        @workout = @component.workoutNodeForWorkout(@model)

      it "creates an ExistingWorkoutComponent", ->
        chai.expect(@existingWorkoutNodeSpy.called).to.be.true

      it "passes in the model", ->
        chai.expect(@workout.props.model).to.equal @model

    describe "for a new workout", ->
      beforeEach ->
        @model = new app.models.WorkoutModel
          id: 1
          name: "Velociraptor"
          device: id: 2
        @workout = @component.workoutNodeForWorkout(@model)

      it "creates a WorkoutComponent", ->
        chai.expect(@workoutNodeSpy.called).to.be.true

      it "passes in the model", ->
        chai.expect(@workout.props.model).to.equal @model
