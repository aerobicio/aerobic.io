require "interactor"

# Takes a member_id and an unfollowed_id and inserts an Activity::UnfollowedUser
# record into the members feed.
#
class AddUnFollowingToActivityFeeds
  include Interactor

  def perform
    Activity::UnfollowedUser.create(user_id: member_id,
                                    activity_user_id: member_id,
                                    activity_followed_user_id: unfollowed_id)

    context[:member] = User.find(member_id)
  end
end
