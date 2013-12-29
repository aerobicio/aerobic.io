require "interactor"

# Handles tcx files as they are uploaded via the Garmin Communicator Plugin
# and drops them on the floor for now.
#
class ProcessUploadedTcxFile
  include Interactor

  def perform
    if context[:activity]
      context[:tcxfile] = TcxFile.new(xml_data: activity)
    else
      context[:notice] = "No TCX File found"
      context.fail!
    end
  end
end
