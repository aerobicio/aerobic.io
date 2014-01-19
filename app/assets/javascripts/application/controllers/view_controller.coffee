# The view controller is the base class for binding to an element and adding
# logic.
@app.controllers.ViewController = class ViewController

  # This is the keycode returned for a kepress event on "enter".
  enterKeycode: 13

  constructor: (options) ->
    el   = options?.el
    @$el = @_jQueryifyElement(el)
    @el  = @$el[0]
    @initialize options
    @bindEvents()

  initialize: -> # Abstract method.

  bindEvents: -> # Abstract method.

  hide: -> @$el.hide()
  show: -> @$el.show()

  toggle: (value) -> @$el.toggle(value)

  _jQueryifyElement: (el) ->
    if @_isJqueryObject(el) then el else @_createJqueryObject(el)

  _isJqueryObject: (el) -> el instanceof jQuery

  _createJqueryObject: (el) -> $(el)

