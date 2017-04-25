class Rename < ActiveRecord::Migration
  def change
    rename_column :categories_groups_unit_categories, :unit_categoriy_id, :unit_category_id
  end
end
