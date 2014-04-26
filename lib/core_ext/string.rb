# Extensions to the built in String class
#
class String
  def capitalize_first_letter
    slice(0, 1).capitalize + slice(1..-1)
  end
end
