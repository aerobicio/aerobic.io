###* @jsx React.DOM ###

@app.components.WorkoutsComponent = React.createClass
  displayName: 'app.components.WorkoutsComponent'
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.WorkoutsCollection).isRequired
    progressModel: React.PropTypes.instanceOf(app.models.ProgressModel).isRequired
    hasDeviceSelected: React.PropTypes.bool.isRequired

  getInitialState: ->
    deviceHasFinishedLoading: false

  componentDidMount: ->
    @props.progressModel
      .on("complete", => @setState(deviceHasFinishedLoading: true))
      .on("empty", => @setState(deviceHasFinishedLoading: false))

  classes: ->
    React.addons.classSet
      "workouts-list": true

  onClick: (event) ->
    event.preventDefault()
    @props.collection.uploadSelectedWorkouts()

  render: ->
    WorkoutListHeaderComponent = app.components.WorkoutListHeaderComponent
    WorkoutListComponent = app.components.WorkoutListComponent

    if @props.hasDeviceSelected and @state.deviceHasFinishedLoading
      `<div>
        <WorkoutListHeaderComponent collection={this.props.collection} onClickHandler={this.onClick} />
        <WorkoutListComponent collection={this.props.collection} />
      </div>`
    else if @props.hasDeviceSelected and not @state.deviceHasFinishedLoading
      `<div>
        Reading workouts — hang tight!
      </div>`
    else
      `<div>
        Select a device above to start adding workouts!
      </div>`
