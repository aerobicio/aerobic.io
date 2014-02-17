require 'interactor'

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
    add_to_activity_feed(member_id)
  end

  def add_to_followed_members_activity_feed
    add_to_activity_feed(followed_id)
  end

  def add_to_members_followers_activity_feed
    member.followers.reduce(true) do |success, follower|
      if member_or_followed_member?(follower.id)
        success
      else
        add_to_activity_feed(follower.id) && success
      end
    end
  end

  def member_or_followed_member?(follower_id)
    [member_id, followed_id].include?(follower_id)
  end

  def add_to_activity_feed(user_id)
    followed_params = {
      user_id: user_id,
      activity_user_id: member_id,
      activity_followed_user_id: followed_id,
    }

    activity = Activity::FollowedUser.create(followed_params)
    activity.save
  end
end
