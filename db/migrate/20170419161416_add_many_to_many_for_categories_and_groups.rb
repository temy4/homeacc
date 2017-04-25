class AddManyToManyForCategoriesAndGroups < ActiveRecord::Migration
    create_table :unit_categories_categories_groups, id: false do |t|
      t.belongs_to :unit_categoriy, index: true
      t.belongs_to :categories_group, index: true
    end
end
