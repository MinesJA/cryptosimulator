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
    rows = []

    Coin.all.each do |coin|
      i += 1
      rows << ["#{i}.", coin.coin_name, "$#{coin.coin_price.round(2)}"]
    end

    table = Terminal::Table.new :headings => ["Num", "Coin Name", "USD Price"], :rows => rows
    table.align_column(1, :right)


    puts table

# 1. Bitcoin | $11230.5
# 2. Ethereum | $1045.18
# 3. Ripple | $1.3073
# 4. Bitcoin Cash | $1637.52
# 5. Cardano | $0.634643
# 6. Stellar | $0.60337
# 7. Litecoin | $179.974
# 8. NEO | $137.559
# 9. EOS | $14.3091
# 10. NEM | $0.946028

  end


  def return_units_given_dollars(usd_amount)
    Coin.update_coin_prices
    usd_amount/self.coin_price
  end

end
