class AddDeviceId < ActiveRecord::Migration
  def change
    add_column :workouts, :device_id, :string, null: true

    add_index :workouts, [:device_id]
  end
end
