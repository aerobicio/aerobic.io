# FollowingHelper provides helper methods for presenting following related
# content
#
module FollowingHelper
  def following_link_for_members(member, other_member)
    return unless $switch_board.following_active?

    # TODO i18n these strings
    unless member == other_member
      if member.follows?(other_member)
        link_to("Unfollow", unfollow_member_path(other_member.id))
      else
        link_to("Follow", follow_member_path(other_member.id))
      end
    end
  end
end
