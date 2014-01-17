class AddUuidToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :uuid, :string, null: true

    add_index :workouts, [:uuid]
  end
end
