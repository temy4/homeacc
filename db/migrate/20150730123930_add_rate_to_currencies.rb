class AddRateToCurrencies < ActiveRecord::Migration
  def change
  	add_column :currencies, :rate, :float, after: :sign
  end
end
