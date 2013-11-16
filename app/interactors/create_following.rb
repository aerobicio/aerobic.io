require "interactor"

# Takes a member_id and a followed_id and sets up the following relationship
# between the member and followed member.
#
class CreateFollowing
  include Interactor

  def perform
    if follow_member
      context[:notice] = "Now following #{followed_member.name}"
    else
      context[:notice] = "Could not follow #{followed_member.name}"
      context.fail!
    end
  end

  private

  def follow_member
    context[:member] = User.find(member_id)
    context[:followed_member] = User.find(followed_id)

    return false if trying_to_follow_yourself?
    return false if already_following_member?

    begin
      member.followings << followed_member
      true
    rescue ActiveRecord::ActiveRecordError => e
      false
    end
  end

  def trying_to_follow_yourself?
    member == followed_member
  end

  def already_following_member?
    member.followings.include?(followed_member)
  end
end
