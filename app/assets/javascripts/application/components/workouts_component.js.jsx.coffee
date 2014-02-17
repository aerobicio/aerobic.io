###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  displayName: 'app.components.WorkoutsComponent'
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.WorkoutsCollection).isRequired
    hasDeviceSelected: React.PropTypes.bool.isRequired

  classes: ->
    React.addons.classSet
      "workouts-list": true

  onClick: (event) ->
    event.preventDefault()
    @props.collection.uploadSelectedWorkouts()

  render: ->
    WorkoutListHeaderComponent = app.components.WorkoutListHeaderComponent
    WorkoutListComponent = app.components.WorkoutListComponent

    if @props.hasDeviceSelected
      `<div>
        <WorkoutListHeaderComponent collection={this.props.collection} onClickHandler={this.onClick} />
        <WorkoutListComponent collection={this.props.collection} />
      </div>`
    else
      `<div>
        Select a device above to start adding workouts!
      </div>`
