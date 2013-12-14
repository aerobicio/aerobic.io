@app.views.UploadWorkoutListView = class UploadWorkoutListView extends app.controllers.BoundViewController
  el: "#UploadWorkoutListView"

  initialize: (options) ->
    @onClickDelegate = options.onClickDelegate

  onClick: (event, context) =>
    event.preventDefault()
    @onClickDelegate()

  onCheck: (event, context) =>
    workout = context.workout
    workout.set(checked: !workout.get('checked'))
