###* @jsx React.DOM ###

@app.components.WorkoutListHeaderComponent = React.createClass
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.WorkoutsCollection).isRequired
    onClickHandler: React.PropTypes.func.isRequired

  getSelectedWorkoutsCount: ->
    @props.collection.getSelectedWorkoutsCount()

  getSelectedWorkouts: ->
    count = @getSelectedWorkoutsCount()
    if count is 0 then "" else "(#{count})"

  getUploadButtonDisabled: ->
    if @getSelectedWorkoutsCount() < 1 then true else false

  render: ->
    selectedWorkoutsCount = @getSelectedWorkouts()
    uploadButtonDisabled = @getUploadButtonDisabled()

    `<header>
      <h6 className="h6">{this.props.collection.length} Workouts found on your device.</h6>
      <button className="workouts__upload-button" disabled={uploadButtonDisabled} onClick={this.props.onClickHandler}>
        Upload Workouts {selectedWorkoutsCount}
      </button>
    </header>`
