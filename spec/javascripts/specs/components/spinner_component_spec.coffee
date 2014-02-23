describe "app.components.SpinnerComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @component = new app.components.SpinnerComponent()
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "spinner"
