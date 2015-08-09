class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :cc_type
      t.string :number_short
      t.string :number_full
      t.integer :month_end
      t.integer :year_end
      t.string :owner
      t.string :alias
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
