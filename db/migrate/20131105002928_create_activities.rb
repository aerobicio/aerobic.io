class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.references :user
      t.string :type

      t.integer :activity_workout_id
      t.integer :activity_user_id
      t.integer :activity_followed_user_id

      t.timestamps
    end

    add_index :activities, :user_id
    add_index :activities, :activity_workout_id
    add_index :activities, :activity_user_id
    add_index :activities, :activity_followed_user_id
    add_foreign_key :activities, :users
    add_foreign_key :activities, :workouts, column: "activity_workout_id"
    add_foreign_key :activities, :users, column: "activity_user_id"
    add_foreign_key :activities, :users, column: "activity_followed_user_id"
  end
end
