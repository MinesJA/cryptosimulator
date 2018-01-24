class AddColumnToCoinTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :coin_transactions, :coin_transaction_type, :string
  end
end
