# The view controller is the base class for binding to an element and adding
# logic.
window.ViewController = class ViewController
  constructor: (options) ->
    @$el = $(options?.el)
    @el  = @$el[0]

    @initialize options
    @_bindEvents()

  initialize: -> # Abstract method.

  hide: -> @$el.hide()
  show: -> @$el.show()

  toggle: (value) -> @$el.toggle(value)

  _bindEvents: -> # Abstract method.
