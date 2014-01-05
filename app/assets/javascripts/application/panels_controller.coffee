window.PanelsController = class PanelsController extends ViewController

  # This is the keycode returned for a kepress event on "enter".
  enterKeycode: 13

  initialize: (options) ->
    @options = _(options).defaults
      navigableHrefSelector:    "[data-href]"
      ignoreabledHrefSelectors: "a"

  _bindEvents: ->
    @$el
      .on("click", @options.navigableHrefSelector, @_onClick)
      .on("keyup", @options.navigableHrefSelector, @_onKeyup)

  _onKeyup: (event) =>
    @_onClick(event) if event.keyCode == @enterKeycode

  _onClick: (event) =>
    return if @_clickShouldBeIgnored $(event.target)
    event.stopImmediatePropagation()
    event.preventDefault()
    Turbolinks.visit $(event.currentTarget).data('href')

  _clickShouldBeIgnored: ($clickedEl) ->
    $clickedEl.closest(@options.ignoreabledHrefSelectors).length > 0
