class ChangeStartingAmountToFloat < ActiveRecord::Migration
  def change
    change_column :money_units, :starting_amount, :float
  end
end
