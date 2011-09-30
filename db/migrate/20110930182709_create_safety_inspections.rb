class CreateSafetyInspections < ActiveRecord::Migration
  def change
    create_table :safety_inspections do |t|
      t.integer :bike_id
      t.integer :inspector_id
      t.datetime :inspection_date

      t.timestamps
    end
  end
end
