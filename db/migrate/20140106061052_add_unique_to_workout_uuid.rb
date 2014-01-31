class AddUniqueToWorkoutUuid < ActiveRecord::Migration
  def change
    remove_index :workouts, :uuid
    add_index :workouts, :uuid, :unique => true
  end
end
