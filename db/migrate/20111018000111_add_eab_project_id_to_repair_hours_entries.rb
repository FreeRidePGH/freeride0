class AddEabProjectIdToRepairHoursEntries < ActiveRecord::Migration
  def change
    add_column :repair_hours_entries, :eab_project_id, :integer
  end
end
