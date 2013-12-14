# The view controller is the base class for binding to an element and adding
# logic.
@app.controllers.BoundViewController = class BoundViewController extends app.controllers.ViewController
  constructor: (options) ->
    super(options)
    @bindView(options?.bindings) unless @viewBinding?

  bindView: (custom_bindings = {}) ->
    bindings = _(custom_bindings).defaults(view: @)
    @viewBinding = rivets.bind(@$el, bindings)
