# TypographyHelper is a wrapper around the Typogruby library which helps
# maintain nice web type in our views
#
module TypographyHelper
  require 'typogruby'

  def improve(text)
    Typogruby.improve(text).html_safe
  end
end
