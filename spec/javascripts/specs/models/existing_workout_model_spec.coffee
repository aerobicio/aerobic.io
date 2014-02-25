describe "app.models.ExistingWorkoutModel", ->
  beforeEach ->
    @attributes =
      formatted_duration: "01:12:32"
      formatted_active_duration: "01:00:00"
      formatted_distance: "12 Kilometers"
    @model = new app.models.ExistingWorkoutModel(@attributes)

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('status')).to.equal "uploaded"

  describe "#date", ->
    beforeEach ->
      @nowDate = new Date(2014, 0, 1, 12, 0, 0)
      @model.attributes.start_time = @nowDate.toString()

    it "returns the date", ->
      chai.expect(@model.date().toString()).to.equal "01/01/2014"

  describe "#dateSince", ->
    beforeEach ->
      @nowDate = new Date(2014, 0, 1, 12, 0, 0)
      @model.attributes.start_time = @nowDate.toString()

    xit "returns the date in the form of a relative string"

  describe "#duration", ->
    it "returns formatted_duration", ->
      chai.expect(@model.duration()).to.equal @attributes.formatted_duration

  describe "#activeDuration", ->
    it "returns formatted_active_duration", ->
      chai.expect(@model.activeDuration()).to.equal @attributes.formatted_active_duration

  describe "#distance", ->
    it "returns formatted_distance", ->
      chai.expect(@model.distance()).to.equal @attributes.formatted_distance
