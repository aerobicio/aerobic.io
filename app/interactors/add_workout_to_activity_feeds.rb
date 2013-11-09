require "interactor"

# Takes a workout from the context, and writes an Activity::AddedWorkout
# object into:
#
#   1. The members feed
#   2. The feeds of members who follow the member
#
class AddWorkoutToActivityFeeds
  include Interactor

  def perform
    workout = context[:workout]
    @member = User.find(context[:member_id])

    Activity::AddedWorkout.create(user_id: @member.id,
                                  activity_user_id: @member.id,
                                  activity_workout_id: workout.id)

    add_workout_to_followers_feeds
  end

  private

  def add_workout_to_followers_feeds
    @member.followers.each do |follower|
      Activity::AddedWorkout.create(user_id: follower.id,
                                    activity_user_id: @member.id,
                                    activity_workout_id: workout.id)
    end
  end
end
