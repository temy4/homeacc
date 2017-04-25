class ChangeTransactionDateToDate < ActiveRecord::Migration
  def change
    remove_column :money_units, :transaction_date
    add_column :money_units, :transaction_date, :date, after: :id
  end
end
