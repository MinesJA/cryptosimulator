class User < ActiveRecord::Base
  has_many :coin_transactions
  has_many :usd_transactions
  has_many :coins, through: :coin_transactions









############-----USD TRANSACTIONS---------##################
  #USD TRANSACTIONS SCHEMA
  # create_table "usd_transactions", force: :cascade do |t|
  #   t.integer "user_id"
  #   t.float "usd_amount"
  #   t.string "usd_transaction_type"
  # end


  def create_usdtransaction(usd_amount, type)
    #Type = "Deposit" || "Exchange" (Buys or Sells)
    #Buys = -usd_amount
    #Sells = +usd_amount
    #Deposits = +usd_amount

    UsdTransaction.create(self.id, usd_amount, type)
    #self.id??
  end


  def users_usdtransactions
    #returns all USD Transactions for this user
    #do we need to do this in activerecord?
    UsdTransaction.all.select do
      |usdtransaction| usdtransaction.user_id == self.id
    end
  end

  def users_deposits
    #returns array of all USD Transactions that are deposits

    self.users_usdtransactions.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Deposit"
    end

  end


  def return_cash_on_hand
    #iterates over all transactions for user it's called on and returns sum
    self.users_usdtransactions.inject(0){|sum,x| sum + x }
  end


  def return_total_deposited_cash
    self.users_deposits.inject(0){|sum,x| sum + x }
  end



############################################################

# Creation	#buy_coins(coin_name, amount_to_buy)
# Creation	#sell_coins(coin_name, amount_to_sell)



end
