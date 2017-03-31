class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.date :completed_on, null: false
      t.integer :account_id, null: false
      t.integer :asset_id, null: false
      t.monetize :amount, null: false
      t.monetize :price, null: false
      t.decimal :shares, null: false
      t.string :type, null: false

      t.timestamps

      t.index :account_id
      t.index :asset_id
    end
  end
end
