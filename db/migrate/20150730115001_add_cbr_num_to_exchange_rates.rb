class AddCbrNumToExchangeRates < ActiveRecord::Migration
  def change
  	add_column :exchange_rates, :cbr_num, :string, after: :id
  end
end
