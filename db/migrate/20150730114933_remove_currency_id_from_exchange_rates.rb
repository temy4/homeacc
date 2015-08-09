class RemoveCurrencyIdFromExchangeRates < ActiveRecord::Migration
  def change
  	remove_column :exchange_rates, :currency_id
  end
end
