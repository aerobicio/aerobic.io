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
    unless all_feeds_updated?
      context[:notice] = "Could not follow #{followed_member.name}"
      context.fail!
    end
  end

  private

  def all_feeds_updated?
    add_to_members_activity_feed &&
    add_to_followed_members_activity_feed &&
    add_to_members_followers_activity_feed
  end

  def add_to_members_activity_feed
    Activity::FollowedUser.create(user_id: member_id,
                                  activity_user_id: member_id,
                                  activity_followed_user_id: followed_id)
  end

  def add_to_followed_members_activity_feed
    Activity::FollowedUser.create(user_id: followed_id,
                                  activity_user_id: member_id,
                                  activity_followed_user_id: followed_id)
  end

  def add_to_members_followers_activity_feed
    member.followers.inject(true) do |success, follower|
      add_to_followers_feed(follower) && success
    end
  end

  def add_to_followers_feed(follower)
    Activity::FollowedUser.create(user_id: follower.id,
                                  activity_user_id: member_id,
                                  activity_followed_user_id: followed_id)
  end
end
