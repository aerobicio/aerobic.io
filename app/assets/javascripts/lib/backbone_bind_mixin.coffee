# http://eldar.djafarov.com/2013/11/reactjs-mixing-with-backbone
@lib.BackboneBindMixin =
  bindTo: (model, key) ->
    value: model.get(key)
    requestChange: (value) => model.set(key, value)
