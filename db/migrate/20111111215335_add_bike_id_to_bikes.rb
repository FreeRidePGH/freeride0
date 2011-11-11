class AddBikeIdToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :bike_id, :integer
  end
end
