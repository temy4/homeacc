class CreateMoneyUnits < ActiveRecord::Migration
  def change
    create_table :money_units do |t|
      t.integer :counterparty_id
      t.integer :currency_id
      t.integer :tax_id
      t.string :type
      t.string :name
      t.string :period
      t.integer :current_period_price
      t.integer :next_period_price
      t.date :current_period
      t.date :next_period
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
