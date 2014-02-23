describe "app.components.ExistingWorkoutComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @model = new app.models.ExistingWorkoutModel
    @model.date = -> ""
    @component = app.components.ExistingWorkoutComponent(model: @model)
    React.renderComponent(@component, @fixture[0])

  afterEach ->
    React.unmountComponentAtNode(@fixture[0])
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "panel"
      chai.expect(@component.classes()).to.have.string "uploader-workout"
      chai.expect(@component.classes()).to.have.string "is-uploaded"

  describe "#iconClass", ->
    it "has default classes", ->
      chai.expect(@component.iconClasses()).to.have.string "panel__figure"
      chai.expect(@component.iconClasses()).to.have.string "uploader-workout__icon"
      chai.expect(@component.iconClasses()).to.have.string "is-uploaded"
