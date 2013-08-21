require "active_support/core_ext/object/try"

# HomesHelper contains the view classes used in each view located in
# homes/view.
#
module HomesHelper

  NEWSLETTER_FORM = {
    action:       "http://aerobicio.createsend.com/t/t/s/itoy/",
    field_name:   "cm-itoy-itoy",
    field_id:     "itoy-itoy"
  }

  # NewHomesHelper is the view class used in views/homes/show
  #
  class NewHomesHelper
    def newsletter_form_action
      NEWSLETTER_FORM['action']
    end

    def newsletter_form_field_name
      NEWSLETTER_FORM['field_name']
    end

    def newsletter_form_field_id
      NEWSLETTER_FORM['field_id']
    end
  end
end
