require 'digest/sha1'

# Service class to create a workout given a representation of a FIT or TCX file
# and a device, workout and member ID.
#
class WorkoutCreator
  def initialize(member_id, device_id, workout_id, file)
    @member_id = member_id
    @device_id = device_id
    @workout_id = workout_id
    @file = file
  end

  def persist_workout
    Workout.create(uuid: workout_uuid,
                   device_id: @device_id,
                   device_workout_id: @workout_id,
                   active_duration: @file.active_duration,
                   distance: @file.distance,
                   duration: @file.duration,
                   end_time: @file.end_time,
                   start_time: @file.start_time,
                   user_id: @member_id
                  )
  end

  private

  def workout_uuid
    Digest::SHA1.hexdigest("#{@workout_id}:#{@device_id}")
  end
end
