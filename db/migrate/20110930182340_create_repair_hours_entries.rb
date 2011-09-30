class CreateRepairHoursEntries < ActiveRecord::Migration
  def change
    create_table :repair_hours_entries do |t|
      t.integer :user_id
      t.integer :bike_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
