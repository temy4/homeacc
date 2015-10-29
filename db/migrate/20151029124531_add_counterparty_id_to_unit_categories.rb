class AddCounterpartyIdToUnitCategories < ActiveRecord::Migration
  def change
  	add_column :unit_categories, :counterparty_id, :integer, after: :name
  end
end
