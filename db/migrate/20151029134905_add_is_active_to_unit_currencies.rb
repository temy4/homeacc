class AddIsActiveToUnitCurrencies < ActiveRecord::Migration
  def change
  	add_column :unit_categories, :is_active, :boolean, after: :counterparty_id
  end
end
