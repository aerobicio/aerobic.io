###* @jsx React.DOM ###

@app.components.SVGImageReplaceComponent = React.createClass
  propTypes:
    src: React.PropTypes.string

  getInitialState: ->
    hasReplacement: false

  componentDidMount: ->
    promise = jQuery.ajax(url: @props.src)
    promise.done(@_didFinishLoadingReplacement)
    promise.fail(@_didFailLoadingReplacement)
    promise

  render: ->
    `<div/>`

  _didFinishLoadingReplacement: (data) ->
    $svg = jQuery(data.getElementsByTagName('svg'))
    jQuery(@getDOMNode()).html($svg)

  _didFailLoadingReplacement: ->
    debugger
