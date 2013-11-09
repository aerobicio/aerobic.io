require "interactor"

# Takes a member_id, and a followed_id and inserts Activity::FolowedUser records
# into:
#   1. The member feed.
#   2. The followed members feed.
#   3. The feeds of members who follow the member.
#
class AddFollowingToActivityFeeds
  include Interactor

  def perform
    Activity::FollowedUser.create(user_id: member_id,
                                  activity_user_id: member_id,
                                  activity_followed_user_id: followed_id)

    Activity::FollowedUser.create(user_id: followed_id,
                                  activity_user_id: member_id,
                                  activity_followed_user_id: followed_id)


    member.followers.each do |user|
      Activity::FollowedUser.create(user_id: user.id,
                                    activity_user_id: member_id,
                                    activity_followed_user_id: followed_id)
    end
  end
end
