class RemoveCellarFromBottles < ActiveRecord::Migration[5.1]
  def change
    remove_reference :bottles, :cellar, foreign_key: true
    add_reference :bottles,  :user, foreign_key: true
  end
end
