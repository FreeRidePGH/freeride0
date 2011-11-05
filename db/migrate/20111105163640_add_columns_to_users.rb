class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_text_phone, :boolean
  	add_column :users, :address, :string
  end
end
