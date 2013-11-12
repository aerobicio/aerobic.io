require "interactor"

# Takes a member_id and a followed_id and sets up the following relationship
# between the member and followed member.
#
class CreateFollowing
  include Interactor

  def perform
    follow_member

    if member.save
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

    member.followings << followed_member
  end
end
