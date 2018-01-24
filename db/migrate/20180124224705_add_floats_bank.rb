class AddFloatsBank < ActiveRecord::Migration[5.1]
  def change
    change_column :bank_accounts, :deposited_usd_amount, :float
    change_column :bank_accounts, :availible_usd_amount, :float
    change_column :bank_accounts, :bitcoin_amount, :float
    change_column :bank_accounts, :ethereum_amount, :float
    change_column :bank_accounts, :ripple_amount, :float
    change_column :bank_accounts, :bitcoin_cash_amount, :float
    change_column :bank_accounts, :cardano_amount, :float
    change_column :bank_accounts, :stellar_amount, :float
    change_column :bank_accounts, :nem_amount, :float
    change_column :bank_accounts, :eos_amount, :float
    change_column :bank_accounts, :neo_amount, :float
  end
end
