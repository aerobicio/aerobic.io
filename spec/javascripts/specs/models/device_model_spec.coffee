describe "app.models.DeviceModel", ->
  beforeEach ->
    @model = new app.models.DeviceModel

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('selected')).to.be.false

  describe "#getActivities", ->
    beforeEach ->
      @model.attributes.activities = sinon.spy()

    it "loads activities from the device", ->
      @model.getActivities()
      chai.expect(@model.attributes.activities.called).to.be.true
