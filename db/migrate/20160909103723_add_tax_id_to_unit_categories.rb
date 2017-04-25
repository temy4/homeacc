class AddTaxIdToUnitCategories < ActiveRecord::Migration
  def change
    add_column :unit_categories, :tax_id, :integer, after: :counterparty_id
  end
end
