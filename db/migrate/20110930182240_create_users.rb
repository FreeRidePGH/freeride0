class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :encrypted_password
      t.string :salt
      t.decimal :account_value
      t.boolean :has_read_packet
      t.integer :role

      t.timestamps
    end
  end
end
