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
    #Type = "Deposit" || "Buy" || "Sell"
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


  def users_buys
    self.users_usdtransactions.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Buy"
    end
  end


  def users_sells
    self.users_usdtransactions.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Sell"
    end
  end

  #To cut down on code we could combine users_buys, users_sells, users_deposits
  #into one and pass in the string ("Buy" "Sell" "Deposit") in as an argument


  def return_cash_on_hand
    #iterates over all transactions for user it's called on and returns sum
    self.users_usdtransactions.inject(0){|sum,x| sum + x }
  end


  def return_total_deposited_cash
    self.users_deposits.inject(0){|sum,x| sum + x }
  end

  def return_growth_rate

    



############################################################

# Creation	#buy_coins(coin_name, amount_to_buy)
# Creation	#sell_coins(coin_name, amount_to_sell)



end
