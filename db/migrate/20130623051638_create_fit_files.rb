class CreateFitFiles < ActiveRecord::Migration
  def change
    create_table :fit_files do |t|
      t.string :name, null: false
      t.binary :binary_data, null: false
    end
  end
end
