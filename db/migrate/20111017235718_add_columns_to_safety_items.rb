class AddColumnsToSafetyItems < ActiveRecord::Migration
  def change
    add_column :safety_items, :description, :string
    add_column :safety_items, :instructions, :string
  end
end
