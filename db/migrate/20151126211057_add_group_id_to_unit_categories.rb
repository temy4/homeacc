class AddGroupIdToUnitCategories < ActiveRecord::Migration
  def change
    add_column :unit_categories, :categories_group_id, :integer, after: :id
  end
end
