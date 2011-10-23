class RemoveColumnsFromBikes < ActiveRecord::Migration
  def change
    remove_column :bikes, :bike_id
    remove_column :bikes, :quality
    remove_column :bikes, :condition
    remove_column :bikes, :status
  end
end
