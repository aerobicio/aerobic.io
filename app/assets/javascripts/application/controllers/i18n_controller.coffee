# The I18nController provides an API for translating strings.
@app.controllers.I18nController = class I18nController
  # Returns a new I18nController for the given translations.
  constructor: (translations) ->
    @translations = translations

  # Returns the translation with the given key path. If the translation string
  # is interpolated then the given values will be substituted.
  t: (key, {values, options} = {}) ->
    values ?= {}
    options = _(options ?= {}).defaults prefix: ''

    key = @_joinPrefix(options.prefix, key)
    translation = @_findTranslation(key)

    if !translation
      throw new Error "Invalid translation key path: #{key}"
    @_substitute(translation, values)

  _joinPrefix: (prefix, key) ->
    _.compact(prefix.split('.').concat(key.split('.'))).join('.')

  _substitute: (string, values) ->
    keys = _.keys(values)

    _(keys).reduce (string, key) ->
      string.replace("%{#{key}}", values[key])
    , string

  _findTranslation: (key) ->
    keys = key.split('.')
    _(keys).reduce (object, key) ->
      object?[key]
    , @translations
