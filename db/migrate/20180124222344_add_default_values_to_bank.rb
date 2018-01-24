class AddDefaultValuesToBank < ActiveRecord::Migration[5.1]
  def change
    change_column_default :bank_accounts, :deposited_usd_amount, 0
    change_column_default :bank_accounts, :availible_usd_amount, 0
    change_column_default :bank_accounts, :bitcoin_amount, 0
    change_column_default :bank_accounts, :ethereum_amount, 0
    change_column_default :bank_accounts, :ripple_amount, 0
    change_column_default :bank_accounts, :bitcoin_cash_amount, 0
    change_column_default :bank_accounts, :cardano_amount, 0
    change_column_default :bank_accounts, :stellar_amount, 0
    change_column_default :bank_accounts, :nem_amount, 0
    change_column_default :bank_accounts, :eos_amount, 0
    change_column_default :bank_accounts, :neo_amount, 0
  end
end
