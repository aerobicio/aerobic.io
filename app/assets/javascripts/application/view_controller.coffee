# The view controller is the base class for binding to an element and adding
# logic.
window.ViewController = class ViewController
  constructor: (options) ->
    @$el = $(options?.el)
    @el = @$el[0]
    @initialize options
    @bindEvents()

  initialize: -> # Abstract method.

  bindEvents: -> # Abstract method.

  hide: -> @$el.hide()
  show: -> @$el.show()

  toggle: (value) -> @$el.toggle(value)
