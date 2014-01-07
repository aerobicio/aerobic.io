describe "app.models.ExistingWorkoutModel", ->
  beforeEach ->
    @model = new app.models.ExistingWorkoutModel

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('status')).to.equal "uploaded"

  describe "#date", ->
    beforeEach ->
      @nowDate = new Date
      @model.attributes.start_time = @nowDate.toString()

    it "returns the date", ->
      chai.expect(@model.date().toString()).to.equal @nowDate.toString()

    it "returns a Date object", ->
      chai.expect(@model.date()).to.be.an.instanceof(Date)
