describe "app.components.DeviceComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @model = new Backbone.Model
    @progressModel = new Backbone.Model
    @selectDeviceHandlerStub = sinon.stub()
    @selectDeviceHandlerStub = sinon.stub()
    @component = app.components.DeviceComponent(
      model: @model
      progressModel: @progressModel
      selectDeviceHandler: @selectDeviceHandlerStub,
      unselectDeviceHandler: @selectDeviceHandlerStub
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "panel"
      chai.expect(@component.classes()).to.have.string "devices-list__device"

    it "has a selected class if the component state is selected", ->
      @model.set(selected: true)
      chai.expect(@component.classes()).to.have.string "is-selected"

    it "has an un-selected class if the component state is selected", ->
      @component.props.model.set(selected: false)
      chai.expect(@component.classes()).to.have.string "is-not-selected"
