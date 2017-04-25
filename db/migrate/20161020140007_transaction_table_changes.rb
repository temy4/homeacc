class TransactionTableChanges < ActiveRecord::Migration
  def change
    rename_column :money_units, :current_period, :starting_period
    rename_column :money_units, :current_period_price, :starting_amount
    rename_column :money_units, :period, :job_description
    remove_column :money_units, :next_period_price
    remove_column :money_units, :next_period
  end
end
