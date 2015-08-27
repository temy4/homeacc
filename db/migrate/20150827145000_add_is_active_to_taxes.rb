class AddIsActiveToTaxes < ActiveRecord::Migration
  def change
    add_column :taxes, :is_active, :boolean
  end
end
