###* @jsx React.DOM ###

@app.components.WorkoutListHeaderComponent = React.createClass
  displayName: 'app.components.WorkoutListHeaderComponent'
  mixins: [@lib.BackboneModelMixin]
  propTypes:
    collection: React.PropTypes.instanceOf(app.collections.WorkoutsCollection).isRequired
    onClickHandler: React.PropTypes.func.isRequired

  classes: ->
    React.addons.classSet
      "uploader-header": true

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

    `<header className={this.classes()}>
      <h6 className="h5 subtle-text uploader-header__title">
        We found {this.props.collection.length} new workouts — awesome!
      </h6>
      <button className="button uploader-header__button" disabled={uploadButtonDisabled} onClick={this.props.onClickHandler}>
        Upload Workouts {selectedWorkoutsCount}
      </button>
    </header>`
