require 'fit'

class UploadsController < ApplicationController
  layout 'garmin'

  def show
  end

  def create
    fit = params[:activity]

    name = fit.lines.first

    fit = fit.lines.to_a[1..-1].join
    fit = fit.lines.to_a[0..-2].join

    fit = Base64.decode64(fit)

    FitFile.create(name: name, binary_data: fit)

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end
end
