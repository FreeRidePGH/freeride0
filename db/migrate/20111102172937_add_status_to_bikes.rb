class AddStatusToBikes < ActiveRecord::Migration
  def change
    add_column :bikes, :status, :string
  end
end
