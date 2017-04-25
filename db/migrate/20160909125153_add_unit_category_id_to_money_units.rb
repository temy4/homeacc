class AddUnitCategoryIdToMoneyUnits < ActiveRecord::Migration
  def change
    add_column :money_units, :unit_category_id, :integer, after: :id
  end
end
