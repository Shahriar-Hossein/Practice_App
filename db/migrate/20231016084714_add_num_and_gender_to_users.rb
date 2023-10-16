class AddNumAndGenderToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :contact_number, :string
    add_column :users, :gender, :string
  end
end
