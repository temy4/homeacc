class RenameTypeToTransactionType < ActiveRecord::Migration
  def change
    rename_column :money_units, :type, :transaction_type
  end
end
