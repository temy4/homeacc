class AddTransactionDateToMoneyUnits < ActiveRecord::Migration
  def change
    add_column :money_units, :transaction_date, :integer, after: :id
  end
end
