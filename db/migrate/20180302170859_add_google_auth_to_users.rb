class AddGoogleAuthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :googleaccount, :boolean
    add_column :users, :googleimage, :string
  end
end
