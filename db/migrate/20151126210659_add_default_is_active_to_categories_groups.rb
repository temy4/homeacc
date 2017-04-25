class AddDefaultIsActiveToCategoriesGroups < ActiveRecord::Migration
  def up
    change_column_default(:categories_groups, :is_active, 1)
  end

  def down
    change_column_default(:categories_groups, :is_active, nil)
  end
end
