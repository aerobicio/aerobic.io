require 'interactor'

# Takes a workout from the context, and writes an Activity::AddedWorkout
# object into:
#
#   1. The members feed
#   2. The feeds of members who follow the member
#
class AddWorkoutToActivityFeeds
  include Interactor

  def perform
    context.fail! unless add_to_activity_feed(member_id) &&
                         add_to_followers_feeds
  end

  private

  def add_to_activity_feed(user_id)
    activity = Activity::AddedWorkout.new(user_id: user_id,
                                          activity_user_id: member_id,
                                          activity_workout_id: workout.id)
    activity.save
  end

  def add_to_followers_feeds
    context[:member] = User.find(member_id)

    member.followers.reduce(true) do |success, follower|
      add_to_activity_feed(follower.id)
    end
  end
end
