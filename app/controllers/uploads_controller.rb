# UploadsController manages the process of uploading files directly from a
# Garmin device using the Communicator API.
#
# The show action renders the Communicator Device Upload UI.
#
# The create action is called via AJAX and processes a single FIT file.
class UploadsController < ApplicationController
  include UnitsHelper

  before_filter :existing_member_workouts, only: [:show]

  def show
  end

  def create
    ActiveRecord::Base.transaction do
      result = CreateWorkoutFromUploadedFitFile.perform(upload_params)

      raise ActiveRecord::Rollback unless result.success?

      respond_to do |format|
        format.json { render_json_response(result) }
      end
    end
  end

  private

  def render_json_response(result)
    if result.success?
      render json: json_attributes_for_workout(result.context[:workout])
    end
  end

  def existing_member_workouts
    @member_workouts ||= current_user.workouts.load.collect {|workout|
      json_attributes_for_workout(workout)
    }
  end

  def upload_params
    {
      activity: params[:activity],
      device_id: params[:device_id],
      device_workout_id: params[:device_workout_id],
      member_id: current_user.id
    }
  end

  def json_attributes_for_workout(workout)
    workout.attributes.merge({
      formatted_distance: format_distance(workout.distance),
      formatted_active_duration: format_distance(workout.active_duration),
      formatted_duration: format_duration(workout.duration),
    })
  end
end
