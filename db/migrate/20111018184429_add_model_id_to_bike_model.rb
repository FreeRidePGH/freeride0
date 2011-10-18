class AddModelIdToBikeModel < ActiveRecord::Migration
  def change
	add_column :bike_models, :model_id, :integer
  end
end
