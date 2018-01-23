class CreateCoinsTransactionsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :coin_transactions do |t|
      t.integer :user_id
      t.integer :coin_id
      t.integer :coin_amount
      t.integer :coin_price
      t.datetime :coin_transaction_date
    end
  end
end
