class AddDeviceWorkoutIdToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :device_workout_id, :string, null: true

    add_index :workouts, [:device_workout_id]
  end
end
