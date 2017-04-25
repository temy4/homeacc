class RemoveStartingPeriodFromMoneyUnits < ActiveRecord::Migration
  def change
    remove_column :money_units, :starting_period
  end
end
