#= require application/view_controller
#= require cookie-monster/dist/cookie-monster
#
# The NewsletterController is responsible for taking email signups
window.NewsletterController = class NewsletterController extends ViewController
  initialize: (options) ->
    @options = _(options).defaults
      cookieName:     "aerobicUserHasSignedUp"
      buttonSelector: "button"
      successClass:   "is-signed-up"

    @showSuccess() if @userHasSignedUp()

  _bindEvents: ->
    return if @userHasSignedUp()

    @$el.on 'click', @options.buttonSelector, @onClick

  onClick: (event) =>
    event.preventDefault()

    @performRequest().always(@onResponse)

  onResponse: (response) =>
    switch response.Status
      when 200 then @_onSuccess response
      when 400 then @_onFail response

  _onSuccess: (response) =>
    @userHasSignedUp true
    @showSuccess()

  _onFail: (response) =>
    @$el.find('input').focus()

  userHasSignedUp: (value) ->
    monster.set(@options.cookieName, value) if value? and value
    not _.isNull monster.get(@options.cookieName)

  showSuccess: ->
    @$el.addClass @options.successClass

  performRequest: =>
    $.ajax
      url:      @$el.attr("action")
      type:     "POST"
      data:     @$el.serialize()
      dataType: "jsonp"
