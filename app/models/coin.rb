class Coin < ActiveRecord::Base
  has_many :coin_transactions
  has_many :users, through: :coin_transactions

  def self.start_import
    if Coin.all.empty?
      get_json.each do |coin_instance|
        name = coin_instance["name"]
        price = coin_instance["price_usd"]
        marketcap = coin_instance["market_cap_usd"]

        Coin.create(coin_name: name, coin_price: price, coin_marketcap: marketcap)
      end
    end
  end


  def self.update_or_create
    if Coin.all.any?

      Coin.all.each do |coin|
        api_coin = get_json.find {|api_coin| coin.coin_name == api_coin["name"]}

        coin.coin_price = api_coin["price_usd"]
        #coin.coin_marketcap = api_coin["market_cap_usd"]
        coin.save
      end; nil
    end
  end


  def self.return_current_prices
    Coin.all.each do |coin|
      puts "#{coin.coin_name}........#{coin.coin_price}"
    end
  end

    # def self.all_prices
    #   Coin.all.map do |coin|
    #     coin.coin_price
    #   end
    # end

end
