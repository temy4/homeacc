class RemoveUnitCategories < ActiveRecord::Migration
  def change
    remove_column :categories_groups, :unit_categories
  end
end
