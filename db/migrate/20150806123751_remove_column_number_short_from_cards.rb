class RemoveColumnNumberShortFromCards < ActiveRecord::Migration
  def change
  	remove_column :cards, :number_short
  end
end
