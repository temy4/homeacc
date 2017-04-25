class RenameM2MTable < ActiveRecord::Migration
  def change
    rename_table :unit_categories_categories_groups, :categories_groups_unit_categories
  end
end
