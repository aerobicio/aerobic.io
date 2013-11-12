class CreateUsersFollowings < ActiveRecord::Migration
  def change
    create_table :users_followings do |t|
      t.references :user
      t.integer :following_id
    end

    add_index :users_followings, :user_id
    add_index :users_followings, :following_id
    add_foreign_key :users_followings, :users
    add_foreign_key :users_followings, :users, column: "following_id"
  end
end
