require "interactor"

# Takes a member_id and a followed_id and sets up the following relationship
# between the member and followed member.
#
class CreateFollowing
  include Interactor

  def perform
    member = User.find(member_id)
    followed_member = User.find(followed_id)

    member.followings << followed_member

    if member.save
      context[:member] = member
      context[:notice] = "Now following #{followed_member.name}"
    else
      context[:member] = member
      context[:notice] = "Could not follow #{followed_member.name}"
      context.fail!
    end
  end
end
