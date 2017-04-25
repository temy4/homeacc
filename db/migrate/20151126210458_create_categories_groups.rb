class CreateCategoriesGroups < ActiveRecord::Migration
  def change
    create_table :categories_groups do |t|
      t.integer :unit_category_id
      t.string :alias
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
