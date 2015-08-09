class CreateCounterparties < ActiveRecord::Migration
  def change
    create_table :counterparties do |t|
      t.string :counterparty_name

      t.timestamps null: false
    end
  end
end
