# The view controller is the base class for binding to an element and adding
# logic.
@app.controllers.ViewController = class ViewController extends Backbone.View
  constructor: (options) ->
    @$el = $(@el or options?.el)
    @el = @$el[0]

    @initialize(options)

    @_bindEvents()

  initialize: -> # Abstract method.

  hide: -> @$el.hide()
  show: -> @$el.show()

  toggle: (value) -> @$el.toggle(value)

  _bindEvents: -> # Abstract method.
