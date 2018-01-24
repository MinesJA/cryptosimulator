class ChangeIntToFloat < ActiveRecord::Migration[5.1]
  def change
    change_column :coin_transactions, :coin_amount, :float
    change_column :coin_transactions, :coin_price, :float

    change_column :coins, :coin_price, :float
    change_column :coins, :coin_marketcap, :float

    change_column :usd_transactions, :usd_amount, :float

  end
end
