class AddUniquenessConstraintForUserDeviceWorkouts < ActiveRecord::Migration
  def change
    add_index :workouts, [:user_id, :device_id, :device_workout_id],
      unique: true, :name => 'index_user_device_id_device_workout_id'
  end
end
