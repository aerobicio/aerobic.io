# UploadsController manages the process of uploading files directly from a
# Garmin device using the Communicator API.
#
# The show action renders the Communicator Device Upload UI.
#
# The create action is called via AJAX and processes a single FIT or TCX file.
#
class UploadsController < ApplicationController
  layout 'garmin'

  def show
  end

  def create
    ActiveRecord::Base.transaction do
      result = create_workout

      raise ActiveRecord::Rollback unless result.success?
    end

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end

  private

  def create_workout
    case params[:activity_type]
    when "fit"
      CreateWorkoutFromUploadedFitFile.perform(upload_params)
    when "tcx"
      CreateWorkoutFromUploadedTcxFile.perform(upload_params)
    end
  end

  def upload_params
    {
      activity: params[:activity],
      member_id: current_user.id
    }
  end
end
