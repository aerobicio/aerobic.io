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

  describe "#getInitialState", ->
    it "sets the default state", ->
      chai.expect(@component.state.preset).to.equal app.config.spinner.tiny
      chai.expect(@component.state.visible).to.be.true

    describe "passing in props", ->
      beforeEach ->
        @preset = {herp: 'derp'}
        @visible = false
        React.unmountComponentAtNode(@fixtureEl)
        @component = new app.components.SpinnerComponent(preset: @preset, isVisible: @visible)
        React.renderComponent(@component, @fixtureEl)

      it "sets the preset state if the preset props is passed in", ->
        chai.expect(@component.state.preset).to.equal @preset

      it "sets the isVisible state if the visible props is passed in", ->
        chai.expect(@component.state.visible).to.equal @visible
