# FollowingHelper provides helper methods for presenting following related
# content
#
module FollowingHelper
  def following_link_for_members(member, other_member)
    return unless $switch_board.following_active?

    # TODO i18n these strings
    unless member == other_member
      if member.follows?(other_member)
        unfollow_button_for(member)
      else
        follow_button_for(member)
      end
    end
  end

  def member_relationship_status_for_members(member, other_member)
    return unless $switch_board.following_active?

    if member.follows?(other_member)
      "#{member.name} follows you"
    else
      "#{member.name} doesn’t follow you"
    end
  end

  private

  def unfollow_button_for(member)
    button_to("Unfollow #{member.name}", unfollow_member_path(member.id))
  end

  def follow_button_for(member)
    button_to("Follow #{member.name}", follow_member_path(member.id))
  end
end
