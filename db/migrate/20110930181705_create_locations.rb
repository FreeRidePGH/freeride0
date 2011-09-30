class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.integer :hook_number

      t.timestamps
    end
  end
end
