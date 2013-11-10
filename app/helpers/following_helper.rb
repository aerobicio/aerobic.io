# FollowingHelper provides helper methods for presenting following related
# content
#
module FollowingHelper
  def following_link_for_members(member, other_member)
    return unless $switch_board.following_active?

    unless member.id == other_member.id
      if member.follows?(other_member)
        unfollow_button_for(other_member)
      else
        follow_button_for(other_member)
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
    button_to("Unfollow #{member.name}", unfollow_member_path(member.id),
      class: "button--follow")
  end

  def follow_button_for(member)
    button_to("Follow #{member.name}", follow_member_path(member.id),
      class: "button--follow")
  end
end
