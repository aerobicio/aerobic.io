describe "app.models.ProgressModel", ->
  beforeEach ->
    @model = new app.models.ProgressModel

  afterEach ->
    @model = null

  it "triggers a 'complete' event when progress reaches 100 percent", ->
    value = false
    @model.on("complete", -> value = true)
    @model.set(percent: 100)
    chai.expect(value).to.be.true

  it "triggers an 'empty' event when progress is reset to the default value", ->
    @model.set(percent: 100)
    value = false
    @model.on("empty", -> value = true)
    @model.set(@model.defaults)
    chai.expect(value).to.be.true

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
