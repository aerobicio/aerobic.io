require 'fit'

# FitFile represents an uploaded FIT file. It has a name and a stores the
# binary data blob uploaded by the user.
#
# In the future it will be associated with a workout that stores the processed
# data, but for now we do that on the fly when calling methods like totals.
class FitFile < ActiveRecord::Base
  def to_fit
    @fit ||= Fit::File.read(StringIO.new(binary_data))
  end

  def totals
    to_fit.records.select { |m| m.header[:message_type] == 0 }
                  .select { |m| m.header[:local_message_type] == 6 }
                  .first
                  .content
  end

end
