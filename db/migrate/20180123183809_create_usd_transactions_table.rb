class CreateUsdTransactionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :usd_transactions do |t|
      t.integer :user_id
      t.integer :usd_amount
      t.string :usd_transaction_type
    end
  end
end
