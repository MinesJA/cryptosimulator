class ChangeColumnNameRank < ActiveRecord::Migration[5.1]
  def change

    rename_column :bank_accounts, :rank, :gain_loss
  end
end
