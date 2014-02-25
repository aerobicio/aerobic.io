describe "app.components.DeviceComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-component"></div>""").appendTo "body"
    @collection = new app.collections.DevicesCollection [new app.models.DeviceModel]
    @model = @collection.at(0)
    @progressModel = new app.models.ProgressModel
    @onDeviceSelectDelegateStub = sinon.stub()
    @onDeviceUnselectDelegateStub = sinon.stub()
    @component = app.components.DeviceComponent(
      model: @model
      progressModel: @progressModel
      onDeviceSelectDelegate: @onDeviceSelectDelegateStub,
      onDeviceUnselectDelegate: @onDeviceUnselectDelegateStub
    )
    React.renderComponent(@component, @fixture[0])

  afterEach ->
    React.unmountComponentAtNode(@fixture[0])
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "device-list__device"

    it "has a selected class if the component state is selected", ->
      @model.set(selected: true)
      chai.expect(@component.classes()).to.have.string "is-selected"

    it "has an un-selected class if the component state is selected", ->
      @component.props.model.set(selected: false)
      chai.expect(@component.classes()).to.have.string "is-not-selected"

  describe "#onClick", ->
    beforeEach ->
      @event =
        preventDefault: -> return
        stopPropagation: -> return
      @preventDefaultSpy = sinon.spy(@event, 'preventDefault')
      @stopPropagationSpy = sinon.spy(@event, 'stopPropagation')

    it "prevents default", ->
      @component.onClick(@event)
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "stops propagation", ->
      @component.onClick(@event)
      chai.expect(@stopPropagationSpy.called).to.be.true

    describe "when the device is selected", ->
      beforeEach ->
        @unselectAllDevicesSpy = sinon.spy(@collection, 'unselectAllDevices')
        @model.set(selected: true)

      it "unselects all devices on the collection", ->
        @component.onClick(@event)
        chai.expect(@unselectAllDevicesSpy.calledOnce).to.be.true

      it "calls the onDeviceUnselectDelegate delegate with the model", ->
        @component.onClick(@event)
        chai.expect(@onDeviceUnselectDelegateStub.calledWith(@model)).to.be.true

    describe "when the device is not selected", ->
      beforeEach ->
        @selectDeviceSpy = sinon.spy(@collection, 'selectDevice')
        @model.set(selected: false)

      it "selects the clicked device on the collection", ->
        @component.onClick(@event)
        chai.expect(@selectDeviceSpy.calledWith(@model)).to.be.true

      it "calls the onDeviceSelectDelegate delegate with the model", ->
        @component.onClick(@event)
        chai.expect(@onDeviceSelectDelegateStub.calledWith(@model)).to.be.true

  describe "#isSelected", ->
    it "returns true if the device model is selected", ->
      @model.set(selected: true)
      chai.expect(@component.isSelected()).to.be.true

    it "returns false if the device model is not selected", ->
      @model.set(selected: false)
      chai.expect(@component.isSelected()).to.be.false
