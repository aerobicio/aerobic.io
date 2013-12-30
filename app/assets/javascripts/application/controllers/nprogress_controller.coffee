@app.controllers.NprogressController = class NprogressController extends app.controllers.ViewController
  nprogressConfiguration:
    showSpinner: false
    ease: 'ease'
    speed: 300

  initialize: ->
    window.NProgress.configure @nprogressConfiguration
    @delegate = window.NProgress

  bindEvents: ->
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
