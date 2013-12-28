###* @jsx React.DOM ###

@app.components.WorkoutListHeaderComponent = React.createClass
  mixins: [@lib.BackboneMixin]

  render: ->
    selectedWorkoutsCount = @getSelectedWorkouts()
    uploadButtonDisabled = @getUploadButtonDisabled()

    `<header className="workouts__header">
      <h6 className="h6">{this.props.collection.length} Workouts found on your device.</h6>
      <button class="workouts__upload-button" disabled={uploadButtonDisabled} onClick={this.onClick}>
        Upload Workouts {selectedWorkoutsCount}
      </button>
    </header>`

  onClick: (event) ->
    event.preventDefault()
    @props.onClick(event)

  getSelectedWorkoutsCount: ->
    @props.collection.getSelectedWorkoutsCount()

  getSelectedWorkouts: ->
    count = @getSelectedWorkoutsCount()
    if count is 0 then "" else "(#{count})"

  getUploadButtonDisabled: ->
    if @getSelectedWorkoutsCount() < 1 then true else false
