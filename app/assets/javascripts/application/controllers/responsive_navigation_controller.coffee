@app.controllers.ResponsiveNavigationController = class ResponsiveNavigationController extends app.controllers.ViewController
  initialize: ->
    @$bannerEl = @$el.find("[role='banner']")
    @$burgerEl = @$el.find("a.burger")

  bindEvents: ->
    @$el
      .on('page:before-change', @_onPageChange)
    @$burgerEl
      .on("click", @_onClick)
      .on("keyup", @_onKeyup)

  _onKeyup: (event) =>
    @_onClick(event) if event.keyCode == @enterKeycode

  _onClick: (event) =>
    event.stopImmediatePropagation()
    event.preventDefault()
    @toggleNavigationState()

  _onPageChange: =>
    @toggleNavigationState()

  toggleNavigationState: ->
    @$bannerEl.toggleClass('is-expanded')
    @$burgerEl.toggleClass('is-active')

  isExpanded: ->
    @$bannerEl.hasClass('is-expanded')
