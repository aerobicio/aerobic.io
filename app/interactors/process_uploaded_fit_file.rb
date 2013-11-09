require "interactor"
require "base64"

# Handles fit files as they are uploaded via the Garmin Communicator Plugin
# and converts them to FitFile object, then stores them.
#
class ProcessUploadedFitFile
  include Interactor

  def perform
    @fit_file = context[:activity]
    @name = @fit_file.lines.first

    strip_casing_and_decode

    context[:fit_file] = FitFile.new(name: @name,
                                     binary_data: @fit_file)
  end

  private

  def strip_casing_and_decode
    fit_file = @fit_file.lines.to_a[1..-1].join
    fit_file = fit_file.lines.to_a[0..-2].join
    @fit_file = Base64.decode64(fit_file)
  end
end
