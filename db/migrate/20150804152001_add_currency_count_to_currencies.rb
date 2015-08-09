class AddCurrencyCountToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :currency_count, :integer
  end
end
