class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |table|
      table.string :provider, null: false
      table.string :uid, null: false

      table.integer :user_id, null: false

      table.timestamps
    end

    add_index :authentications, [:provider, :uid], unique: true
    add_index :authentications, [:user_id]

    add_foreign_key(:authentications, :users)
  end
end
