class CreateVolunteerHoursEntries < ActiveRecord::Migration
  def change
    create_table :volunteer_hours_entries do |t|
      t.integer :user_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
