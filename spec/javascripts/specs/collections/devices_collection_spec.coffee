describe "app.collections.DevicesCollection", ->
  beforeEach ->
    @garminDelegateDevicesPromise = Q.defer()
    @garminDelegateStub = sinon.stub(devices: -> return)
    @garminDelegateStub.devices.returns(@garminDelegateDevicesPromise.promise)
    @collection = new app.collections.DevicesCollection [], garminDelegate: @garminDelegateStub

  afterEach ->
    @collection = null

  describe "#fetch", ->
    it "asks the garminDelgate for a list of devices", ->
      @collection.fetch()
      chai.expect(@garminDelegateStub.devices.called).to.be.true

    it "resets the collection with the returned devices", (done) ->
      promise = @collection.fetch()
      promise.done =>
        chai.expect(@garminDelegateStub.devices.called).to.be.true
        done()
      @garminDelegateDevicesPromise.resolve(true)

  describe "#selectDevice", ->
    beforeEach ->
      @unselectAllDevicesSpy = sinon.spy(@collection, 'unselectAllDevices')
      @collection.add foo: 'bar'
      @model = @collection.at(0)

    afterEach ->
      @unselectAllDevicesSpy.restore()

    it "unselects all devices in the collection", ->
      @collection.selectDevice(@model.cid)
      chai.expect(@unselectAllDevicesSpy.called).to.be.true

    it "sets the device as selected", ->
      @collection.selectDevice(@model.cid)
      chai.expect(@model.get('selected')).to.be.true

  describe "#unselectAllDevices", ->
    it "finds selected devices and unselects them", ->
      @collection.add selected: true
      @collection.unselectAllDevices()
      chai.expect(@collection.findWhere(selected: true)).to.be.undefined
