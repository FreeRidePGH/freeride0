class RemoveFrameSizeFromBikes < ActiveRecord::Migration
  def change
    remove_column :bikes, :frame_size
  end
end
