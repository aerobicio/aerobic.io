require "fit"
require "ostruct"

require_relative "../domain/fit_file"

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
    process_fit_file(params[:activity])

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end

  private

  def process_fit_file(fit)
    name = fit.lines.first

    fit = strip_casing(fit)
    fit = Base64.decode64(fit)

    fit_file = Domain::FitFile.new(fit_file_data_object(name, fit))
    fit_file.persist!
  end

  def fit_file_data_object(name, fit)
    OpenStruct.new(user_id: current_user.id, name: name, binary_data: fit)
  end

  def strip_casing(fit)
    fit = fit.lines.to_a[1..-1].join
    fit.lines.to_a[0..-2].join
  end
end