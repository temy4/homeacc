class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.string :name
      t.float :percent
      t.text :desc

      t.timestamps null: false
    end
  end
end
