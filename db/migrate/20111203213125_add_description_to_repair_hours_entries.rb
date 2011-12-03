class AddDescriptionToRepairHoursEntries < ActiveRecord::Migration
  def change
    add_column :repair_hours_entries, :description, :text
  end
end
