class SetDefaultForIsActive < ActiveRecord::Migration
  def up
    change_column_default(:cards, :is_active, 1)
    change_column_default(:money_units, :is_active, 1)
    change_column_default(:taxes, :is_active, 1)
    change_column_default(:unit_categories, :is_active, 1)
  end

  def down
    change_column_default(:cards, :is_active, nil)
    change_column_default(:money_units, :is_active, nil)
    change_column_default(:taxes, :is_active, nil)
    change_column_default(:unit_categories, :is_active, nil)
  end
end
