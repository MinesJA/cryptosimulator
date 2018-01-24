require 'rest-client'
require 'JSON'

# class ApiCommunicator

  def get_json
    info = RestClient.get("https://api.coinmarketcap.com/v1/ticker/?limit=10")
    JSON.parse(info)
    # binding.pry
  end

  def get_coin_name
    get_json.map do |coin_info|
      Coin.create(coin_name: coin_info["name"], coin_price: coin_info["price_usd"], coin_marketcap: coin_info["market_cap_usd"])
    end


# end
