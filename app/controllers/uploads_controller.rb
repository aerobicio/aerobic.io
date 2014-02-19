# UploadsController manages the process of uploading files directly from a
# Garmin device using the Communicator API.
#
# The show action renders the Communicator Device Upload UI.
#
# The create action is called via AJAX and processes a single FIT or TCX file.
#
class UploadsController < ApplicationController
  include UnitsHelper

  before_filter :existing_member_workouts, only: [:show]

  def show
  end

  def create
    ActiveRecord::Base.transaction do
      result = create_workout

      respond_to do |format|
        format.json { render_json_response(result) }
      end
    end
  end

  private

  def create_workout
    ActiveRecord::Base.transaction do
      case params[:activity_type]
      when "fit"
        result = CreateWorkoutFromUploadedFitFile.perform(upload_params)
      when "tcx"
        result = CreateWorkoutFromUploadedTcxFile.perform(upload_params)
      else
        return nil
      end

      raise ActiveRecord::Rollback unless result.success?
      result
    end
  end

  def render_json_response(result)
    if result.success?
      render json: json_attributes_for_workout(result.context[:workout])
    else
      head :unprocessable_entity
    end
  end

  def existing_member_workouts
    @member_workouts ||= current_user.workouts.load.collect {|workout|
      json_attributes_for_workout(workout)
    }
  end

  def upload_params
    {
      activity: params[:workout_data],
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
