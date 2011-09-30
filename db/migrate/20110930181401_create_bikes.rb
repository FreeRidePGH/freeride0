class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :model_id
      t.integer :brand_id
      t.integer :location_id
      t.decimal :wheel_size
      t.decimal :frame_size
      t.decimal :top_tube
      t.decimal :seat_tube
      t.string :color
      t.string :type

      t.timestamps
    end
  end
end
