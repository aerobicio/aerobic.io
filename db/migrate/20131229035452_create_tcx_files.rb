class CreateTcxFiles < ActiveRecord::Migration
  def change
    create_table :tcx_files do |t|
      t.integer :workout_id, null: false
      t.text :xml_data, null: false
    end

    add_index :tcx_files, [:workout_id], unique: true
    add_foreign_key(:tcx_files, :workouts)
  end
end
