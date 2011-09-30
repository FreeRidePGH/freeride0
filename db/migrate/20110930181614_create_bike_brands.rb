class CreateBikeBrands < ActiveRecord::Migration
  def change
    create_table :bike_brands do |t|
      t.string :name

      t.timestamps
    end
  end
end
