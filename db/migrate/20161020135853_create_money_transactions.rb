class CreateMoneyTransactions < ActiveRecord::Migration
  def change
    create_table :money_transactions do |t|
      t.integer :money_unit_id
      t.integer :ref_last_transaction_id
      t.float :amount

      t.timestamps null: false
    end
  end
end
