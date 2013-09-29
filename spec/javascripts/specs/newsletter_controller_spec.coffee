#= require application/newsletter_controller

describe "NewsletterController", ->
  beforeEach ->
    @fixture = $("""
      <form action="/signup" id="newsletter">
        <input type="email" value="">
        <button type="submit">Sign Up</button>
      </form>
    """).appendTo "body"

    @controller = new NewsletterController el: "#newsletter"
    @$el        = @controller.$el

  afterEach ->
    @controller = null
    @fixture.remove()

  describe "#onClick", ->
    beforeEach ->
      event               = preventDefault: -> return
      @eventSpy           = sinon.spy event, 'preventDefault'
      @performRequestStub = sinon.stub(@controller, 'performRequest').returns $.ajax()
      @controller.onClick event

    it "should prevent the default event", ->
      chai.expect(@eventSpy.calledOnce).to.be.true

    it "should perform the ajax request", ->
      chai.expect(@performRequestStub.calledOnce).to.be.true

  describe "#userHasSignedUp", ->
    beforeEach -> @spy = sinon.spy @controller, 'userHasSignedUp'
    afterEach  -> monster.remove @controller.options.cookieName

    it "should return true if the cookie is set", ->
      monster.set(@controller.options.cookieName, true)
      chai.expect(@controller.userHasSignedUp()).to.be.true

    it "should return false if the cookie is not set", ->
      chai.expect(@controller.userHasSignedUp()).to.be.false

    it "should set the cookie if called with something truthy", ->
      @controller.userHasSignedUp(true)
      chai.expect(@controller.userHasSignedUp()).to.be.true

  describe "signed up user", ->
    beforeEach ->
      sinon.stub(NewsletterController.prototype, "userHasSignedUp").returns true
      @controller = new NewsletterController el: "#newsletter"

    it "should tell them they are already signed up", ->
      chai.expect(@$el.hasClass(@controller.options.successClass)).to.be.true

  describe "success", ->
    beforeEach ->
      @controller.onResponse({"Status": 200, "Message": "blah blah blah"})

    it "should show a success message to the user", ->
      chai.expect(@$el.hasClass(@controller.options.successClass)).to.be.true

    it "should set a cookie indicating that the user has signed up", ->
      chai.expect(@controller.userHasSignedUp()).to.be.true
