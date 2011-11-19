class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.integer :bike_id
      t.string :title
      t.string :details
      t.datetime :last_update

      t.timestamps
    end
  end
end
