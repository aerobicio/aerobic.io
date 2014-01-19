describe "ResponsiveNavigationController", ->
  beforeEach ->
    @container  = $("""
      <div>
        <a href="#" class="burger">Burger!</a>
        <div role="banner"></div>
      </div>
    """).appendTo "body"
    @$burgerEl = @container.find('.burger')
    @$bannerEl = @container.find('[role="banner"]')
    @controller = new app.controllers.ResponsiveNavigationController(el: $(document))
    @toggleNavigationStateSpy = sinon.spy(@controller, 'toggleNavigationState')
    @event =
      preventDefault: -> return
      stopImmediatePropagation: -> return
    @preventDefaultSpy = sinon.spy(@event, 'preventDefault')

  afterEach ->
    @controller = null
    @container.remove()
    @toggleNavigationStateSpy.restore()
    @preventDefaultSpy.restore()

  it "hides the navigation when page:before-change is fired", ->
    @$bannerEl.addClass('is-expanded')
    $(document).trigger('page:before-change')
    chai.expect(@toggleNavigationStateSpy.calledOnce).to.be.true
    chai.expect(@$bannerEl.hasClass('is-expanded')).to.be.false

  it "toggles the menu when the burger is clicked", ->
    @$burgerEl.click()
    chai.expect(@toggleNavigationStateSpy.calledOnce).to.be.true
    chai.expect(@$bannerEl.hasClass('is-expanded')).to.be.true

  it "toggles the menu when the burger is triggered with the enter key", ->
    event         = jQuery.Event "keyup"
    event.keyCode = @controller.enterKeycode
    @$burgerEl.focus().trigger event
    chai.expect(@toggleNavigationStateSpy.calledOnce).to.be.true
    chai.expect(@$bannerEl.hasClass('is-expanded')).to.be.true

  it "preventsDefault when the burger is triggered via keyboard", ->
    @controller._onClick(@event)
    chai.expect(@preventDefaultSpy.called).to.be.true

  it "preventsDefault when the burger is triggered via click", ->
    @controller._onClick(@event)
    chai.expect(@preventDefaultSpy.called).to.be.true

  describe "#toggleNavigationState", ->
    it "toggles the state class on the navigation", ->
      @controller.toggleNavigationState()
      chai.expect(@$bannerEl.hasClass('is-expanded')).to.be.true
      chai.expect(@$burgerEl.hasClass('is-active')).to.be.true
      @controller.toggleNavigationState()
      chai.expect(@$burgerEl.hasClass('is-active')).to.be.false
      chai.expect(@$bannerEl.hasClass('is-expanded')).to.be.false

  describe "#isExpanded", ->
    it "returns true if the navigation is expanded", ->
      @$bannerEl.addClass('is-expanded')
      chai.expect(@controller.isExpanded()).to.be.true

    it "returns false if the navigation is expanded", ->
      @$bannerEl.removeClass('is-expanded')
      chai.expect(@controller.isExpanded()).to.be.false

