class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.decimal :expense_ratio, null: false
      t.string :asset_class, null: false
      t.string :exchange, null: false
      t.string :market_cap, null: false
      t.string :name, null: false
      t.string :style, null: false
      t.string :symbol, null: false

      t.timestamps
    end
  end
end
