class AddRankValue < ActiveRecord::Migration[5.1]
  def change
    change_column_default :bank_accounts, :rank, 0
  end
end
