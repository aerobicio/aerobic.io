#= require application/view_controller

describe "ViewController", ->
  beforeEach ->
    @fixture    = $("""<div id="my-view"></div>""").appendTo "body"
    @spy        = sinon.stub(ViewController.prototype, "_bindEvents")
    @controller = new ViewController el: "#my-view"

  afterEach ->
    @controller = null
    @spy.restore()
    @fixture.remove()

  it "should call the bindEvents method", ->
    chai.expect(@spy.calledOnce).to.be.true

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
