# UploadsController manages the process of uploading files directly from a
# Garmin device using the Communicator API.
#
# The show action renders the Communicator Device Upload UI.
#
# The create action is called via AJAX and processes a single FIT file.
class UploadsController < ApplicationController
  before_filter :member_workouts, only: [:show]

  def show
  end

  def create
    ActiveRecord::Base.transaction do
      result = CreateWorkoutFromUploadedFitFile.perform(upload_params)

      fail ActiveRecord::Rollback unless result.success?

      respond_to do |format|
        format.json { render_json_response(result) }
      end
    end
  end

  private

  def render_json_response(result)
    if result.success?
      render json: result.context[:workout].to_json
    end
  end

  def member_workouts
    @member_workouts ||= current_user.workouts.load
  end

  def upload_params
    {
      activity: params[:activity],
      device_id: params[:device_id],
      device_workout_id: params[:device_workout_id],
      member_id: current_user.id
    }
  end
end
