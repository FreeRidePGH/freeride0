class CreateBikeAssesments < ActiveRecord::Migration
  def change
    create_table :bike_assesments do |t|
      t.integer :bike_id
      t.integer :user_id
      t.string :quality
      t.string :condition
      t.decimal :value

      t.timestamps
    end
  end
end
