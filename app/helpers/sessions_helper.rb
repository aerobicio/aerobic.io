# SessionsHelper contains the view classes used in each view located in
# views/sessions
#
module SessionsHelper

  # NewSessionView is the view class used in views/sessions/new
  class NewSessionView
    def initialize(switch_board = $switch_board)
      @switch_board = switch_board
    end

    def sign_up_active?
      @switch_board.sign_up_is_active?
    end
  end
end
