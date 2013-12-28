describe "app.components.ExistingWorkoutComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @model = new Backbone.Model
    @model.date = -> ""
    @component = app.components.ExistingWorkoutComponent(model: @model)
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountAndReleaseReactRootNode(@fixtureEl)
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "panel"
      chai.expect(@component.classes()).to.have.string "workouts__list__item"
