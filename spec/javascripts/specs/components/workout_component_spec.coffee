describe "app.components.WorkoutComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @model = new app.models.WorkoutModel
      status: false
      checked: false
      device:
        canReadFITActivities: true
    @model.date = -> new Date
    @component = new app.components.WorkoutComponent(model: @model)
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "panel"
      chai.expect(@component.classes()).to.have.string "workouts__list__item"

    it "has a state class if the component state is selected", ->
      @component.setState(checked: true)
      chai.expect(@component.classes()).to.have.string "is-checked"

    it "has an 'is-uploading' class if the component state is uploading", ->
      @component.props.model.set(status: "uploading")
      chai.expect(@component.classes()).to.have.string "is-uploading"

    it "has an 'is-failed' class if the component state is failed", ->
      @component.props.model.set(status: "failed")
      chai.expect(@component.classes()).to.have.string "is-failed"

  describe "#getInitialState", ->
    it "sets the default state", ->
      chai.expect(@component.state.checked).to.be.false

  describe "#toggleChecked", ->
    beforeEach ->
      @event =
        preventDefault: -> return
      @preventDefaultSpy = sinon.spy(@event, 'preventDefault')
      @component.toggleChecked(@event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "toggles the device checked state", ->
      chai.expect(@component.state.checked).to.be.true
      @component.toggleChecked(@event)
      chai.expect(@component.state.checked).to.be.false
      @component.toggleChecked(@event)
      chai.expect(@component.state.checked).to.be.true

    it "toggles the checked state on the model", ->
      chai.expect(@component.props.model.get('checked')).to.be.true
      @component.toggleChecked(@event)
      chai.expect(@component.props.model.get('checked')).to.be.false
      @component.toggleChecked(@event)
      chai.expect(@component.props.model.get('checked')).to.be.true
