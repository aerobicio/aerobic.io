# https://gist.github.com/ssorallen/7883081
@lib.BackboneModelMixin =
  componentDidMount: ->
    @_boundForceUpdate = @forceUpdate.bind(@, null)
    @getBackboneObject().on("all", @_boundForceUpdate, @)

  componentWillUnmount: ->
    @getBackboneObject().off("all", @_boundForceUpdate)

  getBackboneObject: ->
    @props.collection || @props.model
