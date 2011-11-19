class AddImageColumnsToBike < ActiveRecord::Migration
  def change
    add_column :bikes, :image1_file_name,    :string
    add_column :bikes, :image1_content_type, :string
    add_column :bikes, :image1_file_size,    :integer
    add_column :bikes, :image1_updated_at,   :datetime
    
    add_column :bikes, :image2_file_name,    :string
    add_column :bikes, :image2_content_type, :string
    add_column :bikes, :image2_file_size,    :integer
    add_column :bikes, :image2_updated_at,   :datetime
  end
end
