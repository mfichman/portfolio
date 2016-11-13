class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :account_number, null: false
      t.string :institution, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
