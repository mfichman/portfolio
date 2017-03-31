class CreateLots < ActiveRecord::Migration[5.0]
  def change
    create_table :lots do |t|
      t.monetize :cost_basis, null: false
      t.integer :shares, null: false
      t.integer :asset_id, null: false
      t.integer :account_id, null: false
      t.date :opened_on, null: false

      t.timestamps
    end
  end
end
