class AddRankToBankAccount < ActiveRecord::Migration[5.1]
  def change
    add_column :bank_accounts, :rank, :float

  end
end
