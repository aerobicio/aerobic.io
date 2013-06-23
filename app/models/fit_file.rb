require 'fit'

class FitFile < ActiveRecord::Base
  def to_fit
    @fit ||= Fit::File.read(StringIO.new(binary_data))
  end

  def totals
    to_fit.records.select { |m| m.header[:message_type] == 0 && m.header[:local_message_type] == 6 }.first.content
  end

end
