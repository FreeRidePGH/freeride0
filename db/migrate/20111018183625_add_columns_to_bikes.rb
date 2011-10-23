class AddColumnsToBikes < ActiveRecord::Migration
  def change
  	add_column :bikes, :bike_id, :integer
  	add_column :bikes, :date_in, :datetime
  	add_column :bikes, :date_out, :datetime
  	add_column :bikes, :quality, :integer
  	add_column :bikes, :condition, :integer
  	add_column :bikes, :status, :string
  	remove_column :bikes, :type
  end
end
