class ChangeLitecoinType < ActiveRecord::Migration[5.1]
  def change
    change_column_default :bank_accounts, :litecoin_amount, 0
    change_column :bank_accounts, :litecoin_amount, :float

  end
end
