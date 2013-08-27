# SessionsHelper contains the view classes used in each view located in
# views/sessions
#
module SessionsHelper

  # NewSessionView is the view class used in views/sessions/new
  class NewSessionView
    def initialize(rollout = $rollout)
      @rollout = rollout
    end

    def sign_up_active?
      @rollout.active?(:sign_up)
    end
  end
end
