class CreateCoinsTable < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :coin_name
      t.integer :coin_price
      t.integer :coin_marketcap
    end
  end
end
