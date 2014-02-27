require 'interactor'

# Takes a member_id and an unfollowed_id and inserts an Activity::UnfollowedUser
# record into the members feed.
#
class AddUnFollowingToActivityFeeds
  include Interactor

  def perform
    unless add_unfollowed_member_to_activity_feed
      context[:notice] = "Could not unfollow #{unfollowed_member.name}"
      context.fail!
    end
  end

  private

  def add_unfollowed_member_to_activity_feed
    Activity::UnfollowedUser.create(user_id: member_id,
                                    activity_user_id: member_id,
                                    activity_followed_user_id: followed_id)
  end
end
