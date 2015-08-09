class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.integer :currency_id
      t.float :rate

      t.timestamps null: false
    end
  end
end
