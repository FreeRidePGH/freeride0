class AddBrandIdToBikeBrand < ActiveRecord::Migration
  def change
	add_column :bike_brands, :brand_id, :integer
  end
end
