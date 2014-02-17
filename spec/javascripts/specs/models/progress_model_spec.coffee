describe "app.models.ProgressModel", ->
  beforeEach ->
    @model = new app.models.ProgressModel

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('percent')).to.equal -1
      chai.expect(@model.get('message')).to.equal ""

  describe "#isComplete", ->
    it "returns true when the percent is 100", ->
      @model.set(percent: 100)
      chai.expect(@model.isComplete()).to.be.true

    it "returns true when the percent is not 100", ->
      @model.set(percent: 50)
      chai.expect(@model.isComplete()).to.be.false

  describe "#isEmpty", ->
    it "returns true when the percent is the default value", ->
      @model.set(@model.defaults)
      chai.expect(@model.isEmpty()).to.be.true

    it "returns true when the percent is not the default value", ->
      @model.set(percent: 50)
      chai.expect(@model.isEmpty()).to.be.false
