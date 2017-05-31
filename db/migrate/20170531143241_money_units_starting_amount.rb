class MoneyUnitsStartingAmount < ActiveRecord::Migration
  def change
    change_column :money_units, :starting_amount, :decimal, :precision => 16, :scale => 2
  end
end
