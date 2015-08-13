class AddCurrencyIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :currency_id, :integer
  end
end
