# UploadsController manages the process of uploading files directly from a
# Garmin device using the Communicator API.
#
# The show action renders the Communicator Device Upload UI.
#
# The create action is called via AJAX and processes a single FIT file.
class UploadsController < ApplicationController
  layout 'garmin'

  def show
  end

  def create
    CreateWorkoutFromUploadedFitFile.perform(upload_params)

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end

  private

  def upload_params
    {
      activity: params[:activity],
      member_id: current_user.id
    }
  end
end
