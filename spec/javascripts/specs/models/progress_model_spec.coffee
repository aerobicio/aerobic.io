describe "app.models.ProgressModel", ->
  beforeEach ->
    @model = new app.models.ProgressModel

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('percent')).to.equal -1
      chai.expect(@model.get('message')).to.equal ""
