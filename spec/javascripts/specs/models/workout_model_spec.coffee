describe "app.models.WorkoutModel", ->
  beforeEach ->
    @model = new app.models.WorkoutModel

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('status')).to.equal "new"

  describe "#date", ->
    beforeEach ->
      @nowDate = new Date
      @model.attributes.date = @nowDate

    it "returns the date", ->
      chai.expect(@model.date()).to.equal @nowDate

    it "returns a Date object", ->
      chai.expect(@model.date()).to.be.an.instanceof(Date)

  describe "#data", ->
    beforeEach ->
      @model.attributes.getData = sinon.spy()

    it "loads workout data from the device", ->
      @model.data()
      chai.expect(@model.attributes.getData.called).to.be.true
