###* @jsx React.DOM ###

@app.components.WorkoutListHeaderComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  render: ->
    ProgressBarComponent = app.components.ProgressBarComponent
    selectedWorkoutsCount = @getSelectedWorkouts()
    uploadButtonDisabled = @getUploadButtonDisabled()

    `<div>
      Workouts selected for Upload: {selectedWorkoutsCount}
      <button disabled={uploadButtonDisabled} onClick={this.onClick}>Upload!</button>
      <ProgressBarComponent model={this.props.progressModel} />
    </div>`

  onClick: (event) ->
    event.preventDefault()
    @props.onClick(event)

  getSelectedWorkouts: ->
    @props.collection.getSelectedWorkoutsCount()

  getUploadButtonDisabled: ->
    if @getSelectedWorkouts() < 1 then true else false
