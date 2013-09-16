class AddWorkoutIdToFitFile < ActiveRecord::Migration
  def change
    add_column :fit_files, :workout_id, :integer, null: false

    add_index :fit_files, [:workout_id], unique: true
    add_foreign_key(:fit_files, :workouts)
  end
end
