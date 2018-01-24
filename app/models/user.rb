class User < ActiveRecord::Base
  has_many :coin_transactions
  has_many :usd_transactions
  has_many :coins, through: :coin_transactions

############-----NEW USER OR SIGNIN---------################



  def self.create_new_user(name)
    if User.all.find {|user_instance| user_instance.name == name}
      puts "Sorry, that user already exists. Do you want to create a new user?"
      #Need to run "Gets "
    else
      User.create(name: name)
    end
  end

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

    UsdTransaction.create(user_id: self.id, usd_amount: usd_amount, usd_transaction_type: type)
    #self.id??
  end


  def deposit_usd(usd_amount)
    self.create_usdtransaction(usd_amount, "Deposit")
    puts "You just deposited $#{usd_amount}."
    puts "You have $#{100} availible for trading."
  end


  def buy_usd(usd_amount)
  end

  def sell_usd(usd_amount)
  end


  def users_deposits
    #returns array of all USD Transactions that are deposits
    self.usd_transactions.all.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Deposit"
    end
  end


  def users_buys
    self.usd_transactions.all.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Buy"
    end
  end


  def users_sells
    self.usd_transactions.all.select do |usdtransaction|
      usdtransaction.usd_transaction_type == "Sell"
    end
  end

  #To cut down on code we could combine users_buys, users_sells, users_deposits
  #into one and pass in the string ("Buy" "Sell" "Deposit") in as an argument


  def return_usd_balance
    #iterates over all transactions for user it's called on and returns sum
    #We need to refactor the crap out of this
    deposits_and_sells = self.usd_transactions.all.select do |transaction|
      transaction.usd_transaction_type == "Deposit" || transaction.usd_transaction_type == "Sell"
    end

    ds_usd_amounts = deposits_and_sells.map do |transaction|
      transaction.usd_amount
    end

    ds_sum = ds_usd_amounts.inject(0) {|sum,x| sum + x }

    buys = self.usd_transactions.all.select do |transaction|
      transaction.usd_transaction_type == "Buy"
    end

    b_usd_amounts = buys.map do |transaction|
      transaction.usd_amount
    end

    b_sum = b_usd_amounts.inject(0) {|sum,x| sum + x }

    balance = ds_sum - b_sum

    balance
  end


  def return_total_deposited_cash
    self.users_deposits.inject(0){|sum,x| sum + x }
  end



############-----COIN TRANSACTIONS---------##################

# Creation	#buy_coins(coin_name, amount_to_buy)
# Creation	#sell_coins(coin_name, amount_to_sell)

def buy_coin(coin_name_input, coin_amount)
  Coin.update_coin_prices
  #up to date db
  
  coin = Coin.all.find {|coin| coin.coin_name == coin_name_input}

  CoinTransaction.create(user_id: self.id, coin_id: coin.id, coin_amount: coin_amount, coin_price: coin.coin_price, coin_transaction_date: Time.now.getutc)

end



end
