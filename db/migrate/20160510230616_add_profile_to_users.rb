class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :age, :integer
    add_column :users, :hometown, :string
    add_column :users, :info, :string
  end
end
