class CreateQuotes < ActiveRecord::Migration[5.0]
  def change
    create_table :quotes do |t|
      t.datetime :quoted_at
      t.monetize :price
      t.integer :asset_id

      t.timestamps
    end
  end
end
