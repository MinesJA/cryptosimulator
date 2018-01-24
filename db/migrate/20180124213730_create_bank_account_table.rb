class CreateBankAccountTable < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.integer :user_id
      t.integer :deposited_usd_amount
      t.integer :availible_usd_amount
      t.integer :bitcoin_amount
      t.integer :ethereum_amount
      t.integer :ripple_amount
      t.integer :bitcoin_cash_amount
      t.integer :cardano_amount
      t.integer :litecoin_amount
      t.integer :stellar_amount
      t.integer :nem_amount
      t.integer :eos_amount
      t.integer :neo_amount
    end
  end
end
