class AddCbrNumToCurrencies < ActiveRecord::Migration
  def change
    add_column :currencies, :cbr_num, :string, after: :id
  end
end
