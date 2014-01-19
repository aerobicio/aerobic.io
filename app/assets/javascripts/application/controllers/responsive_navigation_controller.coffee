@app.controllers.ResponsiveNavigationController = class ResponsiveNavigationController extends app.controllers.ViewController
  initialize: ->
    @$burgerEl = $('a.burger')

  bindEvents: ->
    @$burgerEl
      .on("click", @_onClick)
      .on("keyup", @_onKeyup)

  _onKeyup: (event) =>
    @_onClick(event) if event.keyCode == @enterKeycode

  _onClick: (event) =>
    event.stopImmediatePropagation()
    event.preventDefault()
    @$el.toggleClass('is-expanded')
    @$burgerEl.toggleClass('is-active')
