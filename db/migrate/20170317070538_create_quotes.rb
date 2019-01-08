class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.date :quoted_on, null: false
      t.monetize :high, null: false
      t.monetize :low, null: false
      t.monetize :close, null: false
      t.monetize :open, null: false
      t.integer :volume, null: false
      t.integer :asset_id, null: false

      t.index :quoted_on

      t.timestamps
    end
  end
end
