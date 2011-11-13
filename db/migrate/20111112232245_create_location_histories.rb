class CreateLocationHistories < ActiveRecord::Migration
  def change
    create_table :location_histories do |t|
      t.integer :bike_id
      t.string :location_name
      t.datetime :last_date_at_location

      t.timestamps
    end
  end
end
