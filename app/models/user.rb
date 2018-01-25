class User < ActiveRecord::Base
  has_many :coin_transactions
  has_one :bank_account
  has_many :usd_transactions
  has_many :coins, through: :coin_transactions

############-----NEW USER OR SIGNIN---------################

  def self.create_new_user(name)
      user = User.create(name: name)
      BankAccount.create(user_id: user.id)
      user
  end

  def self.account_verify(name)
    #checks to make sure an account exists
    #Returns true
    if User.all.find {|user_instance| user_instance.name == name}
      true
    else
      false
    end
  end

  def self.user_login(name)
    #need to add password as argument and check to make sure password matches for username
    User.all.find {|user| user.name == name}
  end

############-----USD TRANSACTIONS---------#################

def deposit_usd(usd_amount)

  self.bank_account.deposited_usd_amount += usd_amount
  self.bank_account.availible_usd_amount += usd_amount

  self.bank_account.save

end


def buy_coin(coin_name, usd_spend)
# binding.pry
  if usd_spend > self.bank_account.availible_usd_amount
    puts "Insufficient funds. Deposit USD."
  else
    coin_table_name = coin_name.downcase + "_amount"

    Coin.update_coin_prices

    coin = Coin.all.find {|coin| coin.coin_name == coin_name}

    coin_amount = usd_spend/coin.coin_price

    CoinTransaction.create(user_id: self.id, coin_id: coin.id, coin_amount: coin_amount, coin_price: coin.coin_price, coin_transaction_date: Time.now.getutc, coin_transaction_type: "Buy")

    self.bank_account.availible_usd_amount -= usd_spend
    self.bank_account[coin_table_name] += coin_amount
    self.bank_account.save
  end

end

  def sell_coin(coin_name_input, coin_amount_to_sell)
    coin_table_name = coin_name_input.downcase + "_amount"

    Coin.update_coin_prices

    coin = Coin.all.find {|coin| coin.coin_name == coin_name_input}

    usd_amount_from_coin_sell = coin_amount_to_sell * coin.coin_price

    # balance_coin = self.return_coin_balance.find {|coin_instance| coin_instance.coin_id == coin.id}

    CoinTransaction.create(user_id: self.id, coin_id: coin.id, coin_amount: coin_amount_to_sell, coin_price: coin.coin_price, coin_transaction_date: Time.now.getutc, coin_transaction_type: "Sell")

    self.bank_account[coin_table_name] -= coin_amount_to_sell
    self.bank_account.availible_usd_amount += usd_amount_from_coin_sell
  end

  def show_user_balance

    hash_balance = self.bank_account.attributes
    selected_balance = hash_balance.select do |key, value|
      key != "id" && key != "user_id" && key != "deposited_usd_amount" && value > 0
    end

    all_sums = 0
    selected_balance.each do |key, value|
      puts "#{key.upcase.gsub("_", " ")} : #{value}"
      coin_key_name = key.split("_").first

        Coin.all.each do |coin|
          if coin.coin_name.downcase == coin_key_name
          each_coin_sum = coin.coin_price * value
          all_sums += each_coin_sum
          end
        end
      end

      puts "Coins value in USD #{all_sums}"
# binding.pry
    # end


      # selected_coins.each do |coin|
      #   puts "Value in USD: #{coin.coin_price * value}"
      # end
    # binding.pry
  end





############-----OLD USD TRANSACTIONS---------#################

  # def create_usdtransaction(usd_amount, type)
  #   #Type = "Deposit" || "Buy" || "Sell"
  #   #Buys = -usd_amount
  #   #Sells = +usd_amount
  #   #Deposits = +usd_amount
  #
  #   UsdTransaction.create(user_id: self.id, usd_amount: usd_amount, usd_transaction_type: type)
  #   #self.id??
  # end



  # def buy_usd(usd_amount)
  #   self.create_usdtransaction(usd_amount, "Sell")
  # end
  #
  # def sell_usd(usd_amount)
  #   self.create_usdtransaction(usd_amount, "Buy")
  # end


  # def users_deposits
  #   #returns array of all USD Transactions that are deposits
  #   self.usd_transactions.all.select do |usdtransaction|
  #     usdtransaction.usd_transaction_type == "Deposit"
  #   end
  # end
  #
  #
  # def users_buys
  #   self.usd_transactions.all.select do |usdtransaction|
  #     usdtransaction.usd_transaction_type == "Buy"
  #   end
  # end
  #
  #
  # def users_sells
  #   self.usd_transactions.all.select do |usdtransaction|
  #     usdtransaction.usd_transaction_type == "Sell"
  #   end
  # end
  #
  # def return_usd_balance
  #   #iterates over all transactions for user it's called on and returns sum
  #   #We need to refactor the crap out of this
  #   deposits_and_sells = self.usd_transactions.all.select do |transaction|
  #     transaction.usd_transaction_type == "Deposit" || transaction.usd_transaction_type == "Sell"
  #   end
  #
  #   ds_usd_amounts = deposits_and_sells.map do |transaction|
  #     transaction.usd_amount
  #   end
  #
  #   ds_sum = ds_usd_amounts.inject(0) {|sum,x| sum + x }
  #
  #   buys = self.usd_transactions.all.select do |transaction|
  #     transaction.usd_transaction_type == "Buy"
  #   end
  #
  #   b_usd_amounts = buys.map do |transaction|
  #     transaction.usd_amount
  #   end
  #
  #   b_sum = b_usd_amounts.inject(0) {|sum,x| sum + x }
  #
  #   balance = ds_sum - b_sum
  #
  #   balance
  # end


  # def return_total_deposited_cash
  #   self.users_deposits.inject(0){|sum,x| sum + x }
  # end



############-----COIN TRANSACTIONS---------##################

  # Creation	#buy_coins(coin_name, amount_to_buy)
  # Creation	#sell_coins(coin_name, amount_to_sell)

  # def buy_coin(coin_name_input, usd_amount)
  #   Coin.update_coin_prices
  #   #up to date db
  #
  #   coin = Coin.all.find {|coin| coin.coin_name == coin_name_input}
  #
  #   coin_amount = usd_amount/coin.coin_price
  #
  #   CoinTransaction.create(user_id: self.id, coin_id: coin.id, coin_amount: coin_amount, coin_price: coin.coin_price, coin_transaction_date: Time.now.getutc, coin_transaction_type: "Buy")
  #
  #   #need to remove before implementation
  #   self.sell_usd(usd_amount)
  # end


  # def sell_coin(coin_name_input, coin_amount_to_sell)
  #   Coin.update_coin_prices
  #
  #   coin = Coin.all.find {|coin| coin.coin_name == coin_name_input}
  #   balance_coin = self.return_coin_balance.find {|coin_instance| coin_instance.coin_id == coin.id}
  #
  #   CoinTransaction.create(user_id: self.id, coin_id: coin.id, coin_amount: coin_amount_to_sell, coin_price: coin.coin_price, coin_transaction_date: Time.now.getutc, coin_transaction_type: "Sell")
  # end

  #def return_coin_balance
    # uniq_transactions = self.coin_transactions.all.uniq {|transaction| transaction.coin_id}
    #
    # duplicate_transactions = self.coin_transactions.all - uniq_transactions
    #
    # uniq_transactions.each do |uniq_transaction|
    #   duplicate_transactions.each do |dup_transaction|
    #     i = 1
    #
    #
    #
    #     if uniq_transaction.coin_transaction_type == "Buy"
    #       if uniq_transaction.coin_id == dup_transaction.coin_id
    #         i += 1
    #         uniq_transaction.coin_amount += dup_transaction.coin_amount
    #
    #         uniq_transaction.coin_price = (uniq_transaction.coin_price + dup_transaction.coin_price)/i
    #       end
    #     else
    #       if uniq_transaction.coin_id == dup_transaction.coin_id
    #         uniq_transaction.coin_amount -= dup_transaction.coin_amount
    #       end
    #     end
    #   end
    #   uniq_transactions
    # end
  #end

  



end
