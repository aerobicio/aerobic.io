class CreateFitFiles < ActiveRecord::Migration
  def change
    create_table :fit_files do |t|
      t.string :name
      t.binary :binary_data
    end
  end
end
