class AddSportColumnToWorkout < ActiveRecord::Migration
  def change
    add_column :workouts, :sport, :string, null: true
  end
end
