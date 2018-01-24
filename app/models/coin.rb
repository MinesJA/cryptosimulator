class Coin < ActiveRecord::Base
  has_many :coin_transactions
  has_many :users, through: :coin_transactions

  def self.update_or_create
    if Coin.all.empty?
      get_json.each do |coin_instance|
        Coin.create(coin_name: coin_instance["name"], coin_price: coin_instance["price_usd"], coin_marketcap: coin_instance["market_cap_usd"])
      end
      else
        Coin.all.each do |coin|
          api_coin = get_json.find do |api_coin|
            coin.coin_name == api_coin["name"]
          end
          coin.coin_price = api_coin["price_usd"]
          coin.coin_marketcap = api_coin["market_cap_usd"]
          coin.save
          puts "#{coin.coin_name} | #{coin.coin_price} | #{coin.coin_marketcap} "
        end
      end; nil

    end

    # def self.all_prices
    #   Coin.all.map do |coin|
    #     coin.coin_price
    #   end
    # end

  end
