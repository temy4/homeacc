class CreateCategoryMappings < ActiveRecord::Migration
  def change
    create_table :category_mappings do |t|
      t.integer :unit_category_id
      t.string :name_pattern

      t.timestamps null: false
    end
  end
end
