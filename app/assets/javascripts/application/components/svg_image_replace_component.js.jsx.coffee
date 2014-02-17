###* @jsx React.DOM ###

@app.components.SVGImageReplaceComponent = React.createClass
  displayName: 'app.components.SVGImageReplaceComponent'
  propTypes:
    src: React.PropTypes.string.isRequired
    className: React.PropTypes.string

  getInitialState: ->
    hasReplacement: false

  componentDidMount: ->
    @promise = jQuery.ajax(url: @props.src)
    @promise.done(@_didFinishLoadingReplacement)
    @promise.fail(@_didFailLoadingReplacement)
    @promise

  componentWillUnmount: ->
    @promise.abort()

  render: ->
    `<div className={this.props.className} />`

  _didFinishLoadingReplacement: (data) ->
    $svg = jQuery(data.getElementsByTagName('svg'))
    jQuery(@getDOMNode()).html($svg)

  _didFailLoadingReplacement: ->
