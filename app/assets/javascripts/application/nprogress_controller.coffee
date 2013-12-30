window.NprogressController = class NprogressController extends ViewController
  initialize: ->
    @delegate = window.NProgress

  _bindEvents: ->
    @$el
      .on('page:fetch', @show)
      .on('page:change', @hide)
      .on('page:restore', @remove)

  show: =>
    @delegate.start()

  hide: =>
    @delegate.done()

  remove: =>
    @delegate.remove()
