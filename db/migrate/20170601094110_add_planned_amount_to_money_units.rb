class AddPlannedAmountToMoneyUnits < ActiveRecord::Migration
  def change
    add_column :money_units, :planned_amount, :decimal, :precision => 16, :scale => 2, after: :starting_amount
  end
end
