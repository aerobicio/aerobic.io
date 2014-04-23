# Support class that can be substituted in tests when you want to impersonate an
# ActiveRecord relation (as an array) with pagination support.
#
class ActiveRecordArrayWithKaminari
  def initialize(array)
    @array = array
  end

  def page(page = 1)
    @array
  end
end
