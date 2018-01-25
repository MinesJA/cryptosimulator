class Coin < ActiveRecord::Base
  has_many :coin_transactions
  has_many :users, through: :coin_transactions

#need to fix this, should import once and then update coin prices going after that


  def self.start_import
    if Coin.all.empty?
      get_json.each do |coin_instance|
        name = coin_instance["name"]
        price = coin_instance["price_usd"]
        #marketcap = coin_instance["market_cap_usd"]

        Coin.create(coin_name: name, coin_price: price)
      end
    end
  end

  def self.update_coin_prices
      Coin.all.each do |coin|
        api_coin = get_json.find {|api_coin| coin.coin_name == api_coin["name"]}
        coin.coin_price = api_coin["price_usd"]
        #coin.coin_marketcap = api_coin["market_cap_usd"]
        coin.save
      end; nil
      #need to figure out how to not return anything, including nil
  end

  def self.find_by_name(coin_name)
    self.all.find {|coin| coin.coin_name.downcase == coin_name.downcase}
  end


  def self.return_current_prices
    Coin.update_coin_prices

    i = 0

    Coin.all.each do |coin|
      i += 1
      puts "#{i}. #{coin.coin_name} | $#{coin.coin_price}"
    end; nil
  end


  def return_units_given_dollars(usd_amount)
    Coin.update_coin_prices
    usd_amount/self.coin_price
  end

end
