class SetUnitCategoryIdTypeToString < ActiveRecord::Migration
  def change
    rename_column :categories_groups, :unit_category_id, :unit_categories
    change_column :categories_groups, :unit_categories, :string
  end
end
