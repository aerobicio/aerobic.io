class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |table|
      table.string :email, null: false
      table.string :name, null: false
      table.string :password_digest, null: false

      table.timestamps
    end

    add_index :identities, [:email], unique: true
  end
end
