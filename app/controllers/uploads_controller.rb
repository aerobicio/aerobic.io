require 'fit'

class UploadsController < ApplicationController
  layout 'garmin'

  def show
  end

  def create
    fit = params[:activity]

    fit = fit.lines.to_a[1..-1].join
    fit = fit.lines.to_a[0..-2].join

    fit = Base64.decode64(fit)
    fit = Fit::File.read(StringIO.new(fit))

    respond_to do |format|
      format.json { render json: "OK" }
    end
  end
end
