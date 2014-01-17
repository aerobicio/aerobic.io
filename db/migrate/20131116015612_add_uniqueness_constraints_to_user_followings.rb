class AddUniquenessConstraintsToUserFollowings < ActiveRecord::Migration
  def change
    add_index :users_followings, [:user_id, :following_id], unique: true
  end
end
