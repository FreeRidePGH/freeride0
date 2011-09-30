class CreateSafetyItemResponses < ActiveRecord::Migration
  def change
    create_table :safety_item_responses do |t|
      t.integer :safety_inspection_id
      t.integer :safety_item_id
      t.boolean :is_checked

      t.timestamps
    end
  end
end
