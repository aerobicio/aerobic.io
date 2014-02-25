describe "app.components.DeviceListComponent", ->
  beforeEach ->
    @fixture = $("""<div id="device-list-component"></div>""").appendTo "body"
    @fixtureEl = @fixture[0]
    @onDeviceSelectDelegateStub = sinon.stub()
    @onDeviceUnselectDelegateStub = sinon.stub()
    @promise = Q.defer().promise
    @collection = new app.collections.DevicesCollection
    @progressModel = new app.models.ProgressModel
    @collection.fetch = sinon.stub().returns(@promise)
    @collection.selectDevice = sinon.stub().returns(sinon.stub())
    @collection.unselectAllDevices = sinon.stub().returns(sinon.stub())
    @component = app.components.DeviceListComponent(
      collection: @collection
      progressModel: @progressModel
      hasDeviceSelected: false
      onDeviceSelectDelegate: @onDeviceSelectDelegateStub
      onDeviceUnselectDelegate: @onDeviceUnselectDelegateStub
    )
    React.renderComponent(@component, @fixtureEl)

  afterEach ->
    React.unmountComponentAtNode(@fixtureEl)
    @fixture.remove()

  describe "#classes", ->
    it "has default classes", ->
      chai.expect(@component.classes()).to.have.string "device-list"

    it "has a selected class if the component state is selected", ->
      @component.setProps(hasDeviceSelected: true)
      chai.expect(@component.classes()).to.have.string "has-device-selected"

  describe "#deviceNode", ->
    it "creates a DeviceComponent", ->
      @collection = new app.collections.DevicesCollection
      @progressModel = new app.models.ProgressModel
      @hasDeviceSelected = sinon.stub()
      @onDeviceSelectDelegate = sinon.stub()
      @onDeviceUnselectDelegate = sinon.stub()
      @component = app.components.DeviceListComponent(
        collection: @collection
        progressModel: @progressModel
        hasDeviceSelected: @hasDeviceSelected
        onDeviceSelectDelegate: @onDeviceSelectDelegate
        onDeviceUnselectDelegate: @onDeviceUnselectDelegate
      )

      @model = sinon.stub()
      deviceNode = @component.deviceNode(@model)
      chai.expect(deviceNode.props.model).to.equal @model
      chai.expect(deviceNode.props.progressModel).to.equal @progressModel
      chai.expect(deviceNode.props.onDeviceSelectDelegate).to.equal @onDeviceSelectDelegate
      chai.expect(deviceNode.props.onDeviceUnselectDelegate).to.equal @onDeviceUnselectDelegate

  # describe "#onSelectDevice", ->
  #   beforeEach ->
  #     @device = sinon.stub()
  #     event =
  #       preventDefault: -> return
  #       stopPropagation: -> return
  #     @preventDefaultSpy = sinon.spy(event, 'preventDefault')
  #     @stopPropagationSpy = sinon.spy(event, 'stopPropagation')
  #     @component.onSelectDevice(@device, event)

  #   xit "prevents default", ->
  #     chai.expect(@preventDefaultSpy.called).to.be.true

  #   xit "stops propagation", ->
  #     chai.expect(@stopPropagationSpy.called).to.be.true

  #   xit "updates the devices collection with the selected device", ->
  #     chai.expect(@collection.selectDevice.calledWith(@device)).to.be.true

  #   xit "sets the device selected state to true", ->
  #     chai.expect(@component.state.hasDeviceSelected).to.be.true

  #   xit "calls the device selected delegate method", ->
  #     chai.expect(@onDeviceSelectDelegateStub.called).to.be.true

  # describe "#onUnselectDevice", ->
  #   beforeEach ->
  #     event =
  #       preventDefault: -> return
  #       stopPropagation: -> return
  #     @preventDefaultSpy = sinon.spy(event, 'preventDefault')
  #     @stopPropagationSpy = sinon.spy(event, 'stopPropagation')
  #     @component.onUnselectDevice(event)

  #   xit "prevents default", ->
  #     chai.expect(@preventDefaultSpy.called).to.be.true

  #   xit "stops propagation", ->
  #     chai.expect(@stopPropagationSpy.called).to.be.true

  #   xit "sets sets the device selected state to false", ->
  #     chai.expect(@component.state.hasDeviceSelected).to.be.false

  #   xit "deselects all devices in the devices collections", ->
  #     chai.expect(@collection.unselectAllDevices.called).to.be.true

  #   xit "calls the device unselected delegate method", ->
  #     chai.expect(@onDeviceUnselectDelegateStub.called).to.be.true
