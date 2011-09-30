class CreateEabProjects < ActiveRecord::Migration
  def change
    create_table :eab_projects do |t|
      t.integer :bike_id
      t.integer :user_id
      t.integer :status
      t.datetime :start_date

      t.timestamps
    end
  end
end
