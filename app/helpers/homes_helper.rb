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

    def features
      I18n.t('homes.show.landing.features').collect do |feature|
        Feature.new(feature["heading"], feature["content"], feature["image"])
      end
    end

    # Features are rendered onto the landing page. The sole purpose of this
    # object is to make rendering in views simpler.
    #
    class Feature
      attr_reader :heading, :content, :image

      def initialize(heading, content, image)
        @heading = heading
        @content = content
        @image = image
      end

      def to_partial_path
        "feature"
      end
    end
  end
end
