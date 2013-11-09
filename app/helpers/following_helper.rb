module FollowingHelper
  include ActionView::Helpers::UrlHelper

  def following_link_for_member(member)
    unless current_user == member
      if current_user.follows?(member)
        link_to("Unfollow", unfollow_path(member.id))
      else
        link_to("Follow", unfollow_member_path(member.id))
      end
    end
  end
end
