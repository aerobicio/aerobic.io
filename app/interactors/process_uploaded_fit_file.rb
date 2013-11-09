require "interactor"
require "fit"
require "ostruct"

require_relative "../domain/fit_file"

# Handles fit files as they are uploaded via the Garmin Communicator Plugin
# and converts them to Domain::FitFile object, then stores them.
#
class ProcessUploadedFitFile
  include Interactor

  def perform
    @fit_file = context[:activity]
    @name = @fit_file.lines.first

    strip_casing_and_decode

    fit_file = Domain::FitFile.new(fit_file_data_object)
    fit_file.persist!
  end

  private

  def fit_file_data_object
    OpenStruct.new(user_id: context[:member_id],
                   name: @name,
                   binary_data: @fit_file)
  end

  def strip_casing_and_decode
    fit_file = @fit_file.lines.to_a[1..-1].join
    fit_file = fit_file.lines.to_a[0..-2].join
    @fit_file = Base64.decode64(fit_file)
  end
end
