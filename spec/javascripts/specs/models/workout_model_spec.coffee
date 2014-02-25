describe "app.models.WorkoutModel", ->
  beforeEach ->
    @attributes =
      id: 1
      device:
        id: 2
    @model = new app.models.WorkoutModel(@attributes)

  afterEach ->
    @model = null

  describe "defaults", ->
    it "has default attributes", ->
      chai.expect(@model.get('status')).to.equal "new"

  describe "#initialize", ->
    describe ".format", ->
      it "sets the format to 'fit' for FIT based devices", ->
        @attributes.device.canReadFITActivities = true
        @model = new app.models.WorkoutModel(@attributes)
        chai.expect(@model.get('format')).to.equal "fit"

      it "sets the format to 'tcx' for TCX based devices", ->
        @attributes.device.canReadActivities = true
        @model = new app.models.WorkoutModel(@attributes)
        chai.expect(@model.get('format')).to.equal "tcx"

    it ".uuid", ->
      # echo -n 1:2 | openssl dgst -sha1
      chai.expect(@model.get('uuid')).to.equal "f9adeea088e0d8fbc89986452daacd1fb0309557"

  describe "#date", ->
    beforeEach ->
      @nowDate = new Date("01/01/2014 12:00:00")
      @model.attributes.date = @nowDate

    it "returns the date", ->
      chai.expect(@model.date()).to.equal "01/01/2014"

  describe "#dateSince", ->
    beforeEach ->
      @nowDate = new Date("01/01/2014 12:00:00")
      @model.attributes.start_time = @nowDate.toString()

    xit "returns the date in the form of a relative string"

  describe "#data", ->
    beforeEach ->
      @model.attributes.getData = sinon.spy()

    it "loads workout data from the device", ->
      @model.data()
      chai.expect(@model.attributes.getData.called).to.be.true

  describe "#isUploading", ->
    it "returns true if the status is uploading", ->
      @model.set(status: "uploading")
      chai.expect(@model.isUploading()).to.be.true

    it "returns false if the status is not uploading", ->
      chai.expect(@model.isUploading()).to.be.false

  describe "#isUploaded", ->
    it "returns true if the status is uploaded", ->
      @model.set(status: "uploaded")
      chai.expect(@model.isUploaded()).to.be.true

    it "returns false if the status is not uploaded", ->
      chai.expect(@model.isUploaded()).to.be.false

  describe "#isFailed", ->
    it "returns true if the status is failed", ->
      @model.set(status: "failed")
      chai.expect(@model.isFailed()).to.be.true

    it "returns false if the status is not failed", ->
      chai.expect(@model.isFailed()).to.be.false

