describe "PanelsController", ->
  beforeEach ->
    @wrapperEl  = $("""<div id="wrapper"></div>""").appendTo 'body'
    @controller = new PanelsController el: @wrapperEl
    @container  = $("""
      <div>
        <div class="panel" data-href="/some-url">
          <h1>Panel title</h1>
          <a href="#misc-link" class="misc-link"><span>Foo</span> bar</a>
        </div>
      </div>
    """).appendTo @wrapperEl

    @$panel         = @container.find ".panel"
    @$expandControl = @$panel.find @controller.options.expandableControlSelector

  afterEach ->
    @controller = null
    @container.remove()

  describe "data-href behaviour when the panel is triggered", ->
    beforeEach ->
      @redirectorStub = sinon.stub(Turbolinks, "visit")

    afterEach ->
      @redirectorStub.restore()

    it "should change the location when the panel is clicked on", ->
      @$panel.find("h1").click()
      chai.expect(@redirectorStub.calledWith('/some-url')).to.be.true

    it "should change the location when focused and the user presses enter", ->
      onKeyupSpy = sinon.spy(@controller, '_onKeyup')
      event         = jQuery.Event "keyup"
      event.keyCode = @controller.enterKeycode
      @$panel.focus().trigger event
      chai.expect(@redirectorStub.calledWith('/some-url')).to.be.true

    it "should not change the location when other links are clicked on", ->
      @$panel.find("a.misc-link").click()
      chai.expect(@redirectorStub.called).to.be.false

      @$panel.find("a.misc-link span").click()
      chai.expect(@redirectorStub.called).to.be.false
