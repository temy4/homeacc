class RenameColumnNumberFullToCardNumberInCards < ActiveRecord::Migration
  def change
  	rename_column :cards, :number_full, :card_number
  end
end
