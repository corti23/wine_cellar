class RemoveSizeFromBottles < ActiveRecord::Migration[5.1]
  def change
    remove_column :bottles, :size, :string
    change_column :bottles, :colour, :integer
    add_column    :bottles, :format, :integer
  end
end
