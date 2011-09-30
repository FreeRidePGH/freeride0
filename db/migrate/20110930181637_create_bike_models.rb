class CreateBikeModels < ActiveRecord::Migration
  def change
    create_table :bike_models do |t|
      t.integer :brand_id
      t.string :name

      t.timestamps
    end
  end
end
