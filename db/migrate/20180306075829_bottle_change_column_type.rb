class BottleChangeColumnType < ActiveRecord::Migration[5.1]
  def change
    change_column(:bottles, :producer, :string)
    change_column(:bottles, :appellation, :string)
    change_column(:bottles, :origin, :string)
    change_column(:bottles, :size, :string)
    change_column(:bottles, :colour, :string)
    change_column(:bottles, :grape, :string)
  end
end
