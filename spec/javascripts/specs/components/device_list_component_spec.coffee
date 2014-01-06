describe "app.components.DeviceListComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @deviceSelectedDelegate = sinon.stub()
    @deviceUnselectedDelegate = sinon.stub()
    @promise = Q.defer().promise
    @collection = new Backbone.Collection
    @collection.fetch = sinon.stub().returns(@promise)
    @collection.selectDevice = sinon.stub().returns(sinon.stub())
    @collection.unselectAllDevices = sinon.stub().returns(sinon.stub())
    @component = app.components.DeviceListComponent(
      collection: @collection
      deviceSelectedDelegate: @deviceSelectedDelegate
      deviceUnselectedDelegate: @deviceUnselectedDelegate
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#getInitialState", ->
    it "sets the initial state", ->
      chai.expect(@component.state.isLoading).to.be.true
      chai.expect(@component.state.hasDeviceSelected).to.be.false

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "devices-list"

    it "has a selected class if the component state is selected", ->
      @component.setState(hasDeviceSelected: true)
      chai.expect(@component.classes()).to.have.string "has-device-selected"

  describe "#deviceNodesForDevices", ->
    beforeEach ->
      @deviceNodeStub = sinon.stub(@component, 'deviceNode').returns(sinon.stub())
      @noDeviceNodeStub = sinon.stub(@component, 'noDeviceNode').returns(sinon.stub())

    it "creates a device node for each device in the collection", ->
      devicesCollection = new Backbone.Collection [sinon.stub(), sinon.stub(), sinon.stub()]
      @component.deviceNodesForDevices(devicesCollection)
      chai.expect(@deviceNodeStub.calledThrice).to.be.true

    it "should show a message if you have no devices", ->
      devicesCollection = new Backbone.Collection []
      @component.deviceNodesForDevices(devicesCollection)
      chai.expect(@deviceNodeStub.called).to.be.false
      chai.expect(@noDeviceNodeStub.calledOnce).to.be.true

  describe "#deviceNode", ->
    it "creates a DeviceComponent", ->
      @model = sinon.stub()
      @progressModel = sinon.stub()
      @selectDeviceHandler = sinon.stub()
      @unselectDeviceHandler = sinon.stub()
      device = @component.deviceNode(@model, @progressModel, @selectDeviceHandler, @unselectDeviceHandler)
      chai.expect(device.props.model).to.equal @model
      chai.expect(device.props.progressModel).to.equal @progressModel
      chai.expect(device.props.selectDeviceHandler).to.equal @selectDeviceHandler
      chai.expect(device.props.unselectDeviceHandler).to.equal @unselectDeviceHandler

  describe "#onSelectDevice", ->
    beforeEach ->
      @device = sinon.stub()
      event =
        preventDefault: -> return
        stopPropagation: -> return
      @preventDefaultSpy = sinon.spy(event, 'preventDefault')
      @stopPropagationSpy = sinon.spy(event, 'stopPropagation')
      @component.onSelectDevice(@device, event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "stops propagation", ->
      chai.expect(@stopPropagationSpy.called).to.be.true

    it "updates the devices collection with the selected device", ->
      chai.expect(@collection.selectDevice.calledWith(@device)).to.be.true

    it "sets the device selected state to true", ->
      chai.expect(@component.state.hasDeviceSelected).to.be.true

    it "calls the device selected delegate method", ->
      chai.expect(@deviceSelectedDelegate.called).to.be.true

  describe "#onUnselectDevice", ->
    beforeEach ->
      event =
        preventDefault: -> return
        stopPropagation: -> return
      @preventDefaultSpy = sinon.spy(event, 'preventDefault')
      @stopPropagationSpy = sinon.spy(event, 'stopPropagation')
      @component.onUnselectDevice(event)

    it "prevents default", ->
      chai.expect(@preventDefaultSpy.called).to.be.true

    it "stops propagation", ->
      chai.expect(@stopPropagationSpy.called).to.be.true

    it "sets sets the device selected state to false", ->
      chai.expect(@component.state.hasDeviceSelected).to.be.false

    it "deselects all devices in the devices collections", ->
      chai.expect(@collection.unselectAllDevices.called).to.be.true

    it "calls the device unselected delegate method", ->
      chai.expect(@deviceUnselectedDelegate.called).to.be.true
