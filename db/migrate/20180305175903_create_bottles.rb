class CreateBottles < ActiveRecord::Migration[5.1]
  def change
    create_table :bottles do |t|
      t.text :producer
      t.text :appellation
      t.text :origin
      t.text :size
      t.integer :vintage
      t.integer :number
      t.text :colour
      t.text :grape
      t.date :dateofpurchase
      t.references :cellar, foreign_key: true

      t.timestamps
    end
  end
end
