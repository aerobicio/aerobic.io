###* @jsx React.DOM ###

@app.components.DeviceComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  classes: ->
    selected = @props.model.get('selected')
    React.addons.classSet(
      "uploader__devices__list__device": true
      "is-selected": selected
      "is-not-selected": !selected
    )

  render: ->
    `<a key={this.props.model.cid} onClick={this.props.onClick} className={this.classes()}>
      {this.props.model.get('name')}
    </a>`
