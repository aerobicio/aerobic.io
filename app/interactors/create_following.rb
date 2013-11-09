require "interactor"

# Takes a member_id and a followed_id and sets up the following relationship
# between the member and followed member.
#
class CreateFollowing
  include Interactor

  def perform
    member = User.find(context[:member_id])
    followed_member = User.find(context[:followed_id])

    member.followings << followed_member

    if member.save
      context[:member] = member
      context[:followed_member] = followed_member
    else
      context[:member] = member
      context.fail!
    end
  end
end
