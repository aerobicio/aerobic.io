#= require application/nprogress_controller

describe "NprogressController", ->
  beforeEach ->
    @fixture = $("""<div></div>""").appendTo "body"
    @controller = new NprogressController el: @fixture
    @controller.delegate = {
      start: -> return
      done: -> return
      remove: -> return
    }
    sinon.stub(@controller.delegate, 'start')
    sinon.stub(@controller.delegate, 'done')
    sinon.stub(@controller.delegate, 'remove')

  afterEach ->
    @fixture.remove()

  describe "#show", ->
    it "shows the loading bar", ->
      @controller.show()
      chai.expect(@controller.delegate.start.calledOnce).to.be.true

  describe "#hide", ->
    it "completes loading", ->
      @controller.hide()
      chai.expect(@controller.delegate.done.calledOnce).to.be.true

  describe "#remove", ->
    it "removes the loading bar", ->
      @controller.remove()
      chai.expect(@controller.delegate.remove.calledOnce).to.be.true
