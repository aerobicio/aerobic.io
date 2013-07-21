class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |table|
      table.string :name, null: false

      table.timestamps
    end
  end
end
