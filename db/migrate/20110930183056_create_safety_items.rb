class CreateSafetyItems < ActiveRecord::Migration
  def change
    create_table :safety_items do |t|
      t.string :name

      t.timestamps
    end
  end
end
