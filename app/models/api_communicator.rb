require 'rest-client'
require 'JSON'

# class ApiCommunicator

  def get_json
    info = RestClient.get("https://api.coinmarketcap.com/v1/ticker/?limit=10")
    JSON.parse(info)
    # binding.pry
  end
