class AddDescriptionToVolunteerHoursEntries < ActiveRecord::Migration
  def change
    add_column :volunteer_hours_entries, :description, :text
  end
end
