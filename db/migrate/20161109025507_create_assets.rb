class CreateAssets < ActiveRecord::Migration[5.0]
  def change
    create_table :assets do |t|
      t.decimal :expense_ratio, null: false
      t.string :category, null: false
      t.string :exchange, null: false
      t.string :name, null: false
      t.string :symbol, null: false

      t.timestamps

      t.index :name, unique: true
    end
  end
end
