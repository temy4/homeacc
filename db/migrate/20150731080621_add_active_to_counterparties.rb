class AddActiveToCounterparties < ActiveRecord::Migration
  def change
    add_column :counterparties, :is_active, :boolean, default: true
  end
end
