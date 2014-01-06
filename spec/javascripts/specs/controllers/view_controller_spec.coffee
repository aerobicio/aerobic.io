describe "app.controllers.ViewController", ->
  beforeEach ->
    @container = $("""<div id="my-view"></div>""").appendTo "body"
    @bindEventsStub = sinon.stub(app.controllers.ViewController.prototype, "bindEvents")
    @createJqueryObjectSpy = sinon.spy(app.controllers.ViewController.prototype, "_createJqueryObject")

  afterEach ->
    @controller = null
    @bindEventsStub.restore()
    @createJqueryObjectSpy.restore()
    @container.remove()

  it "should wrap the el selector in a jQuery object", ->
    new app.controllers.ViewController el: "#my-view"
    chai.expect(@createJqueryObjectSpy.calledOnce).to.be.true

  it "should call the bindEvents method", ->
    new app.controllers.ViewController el: "#my-view"
    chai.expect(@bindEventsStub.calledOnce).to.be.true

  it "should accept an el option that is already a jQuery object", ->
    new app.controllers.ViewController el: $("#my-view")
    chai.expect(@createJqueryObjectSpy.called).to.be.false

  describe "", ->
    beforeEach ->
      @controller = new app.controllers.ViewController el: "#my-view"

    describe "#hide", ->
      it "should hide the element", ->
        @controller.hide()
        chai.expect(@controller.$el.is(":visible")).to.be.false

    describe "#show", ->
      it "should show the element", ->
        @controller.show()
        chai.expect(@controller.$el.is(":visible")).to.be.true

    describe "#toggle", ->
      it "should toggle the element", ->
        @controller.toggle()
        chai.expect(@controller.$el.is(":visible")).to.be.false
        @controller.toggle()
        chai.expect(@controller.$el.is(":visible")).to.be.true
