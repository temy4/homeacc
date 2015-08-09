class RemoveExchangeRatesTable < ActiveRecord::Migration
  def change
  	drop_table :exchange_rates
  end
end
