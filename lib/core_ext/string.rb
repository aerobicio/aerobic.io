class String
  def capitalize_first_letter
    slice(0,1).capitalize + slice(1..-1)
  end
end
