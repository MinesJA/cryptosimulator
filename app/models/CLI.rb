class CLI
  attr_accessor :current_user

  def initialize
    @current_user = nil
    #current_user is supposed to be a User Instance
  end

  ############-----Gives Option to Quit or Go to Main Menu---------###############

  def choices
    puts "Type 'exit' to exit the program or 'menu' to go to the main menu."
    gets.chomp
    #should return response value
  end
  #check

  def handle_choices(input)
    case input.downcase
    when 'exit'
      exit_program
      #check
    when 'menu'
      account_menu
    else
      input
    end
  end
  #check

  ################################################################################

  def self.welcome
    puts "Welcome to CryptoSimulator!"
    cli = CLI.new
    cli.create_or_sign_in
  end
  #checked


  def create_or_sign_in
    puts "Would you like to sign in or log in to an existing account?"
    puts "Enter the number associated with your choice below:"
    puts "1. Create a new account. 2. Log in to an existing account. 3. Exit."
    response = gets.chomp

    case response
    when "1"
      create_account
      #check
    when "2"
      signin
      #check
    when "3"
      exit_program
      #check
    else
      puts "I'm sorry, I didn't get that."
      create_or_sign_in
    end
  end
  #checked


  def create_account
    puts "Great! Let's get you setup."
    puts "What's your name?"
    puts "(This will be the name you'll login with in the future)"
    name = gets.chomp

    if User.account_verify(name)
      puts "I'm sorry, that account already exists."
      create_or_sign_in
    else
      self.current_user = User.create_new_user(name)
      puts "Congratulations, #{name}! You've just created a new account."
      puts "Check out your account below:"
      view_account
    end
  end
#checked


  def signin
<<<<<<< HEAD
=======
    # return_user = {}

>>>>>>> users-interface-a
    puts "Whats your name?"
    name = gets.chomp

    if User.account_verify(name)
<<<<<<< HEAD
      self.current_user = User.user_login(name)
      puts "Welcome back, #{name}!"
      view_account
=======
      # return_user[:name] = name

      puts "Welcome back, #{name}!"
      # puts "what's your password?"
      # password = gets.chomp
      # verify_password
      self.current_user = User.user_login(name)
      self.current_user.show_user_balance
      # account_menu
      # binding.pry
# /////ACCOUNT DETAILS
# /////ACCOUNT MENU

>>>>>>> users-interface-a
    else
      no_matching_username
    end
  end
  #checked


  def no_matching_username
    puts "I'm sorry, we couldn't find that username."
    puts "What would you like to do?"
    puts "1. Try a different username. 2. Create a new user. 3. Exit."
    response = gets.chomp

    case response
    when "1"
      signin
      #check
    when "2"
      create_account
      #check
    when "3"
      exit_program
      #check
    else
      puts "I'm sorry, I didn't get that."
      signin
    end
  end
  #checked


  def view_account
    self.current_user.show_user_balance

    response = choices

    if handle_choices(response) == response
      "I'm sorry, I didn't get that."
      response = choices
    end
  end
  ####$$$$$$$$$$$$$ ----- have a question about this one


  def account_menu
    puts "Choose an option below by entering the number associated with your choice.:"
    puts "1. View Account. 2. Deposit USD. 3. See leaderboard. 4. Buy coins. 5. Sell Coins. 6. Watch prices. 7. Exit "
    response = gets.chomp

    case response
    when "1"
      view_account
      #check
    when "2"
      deposit
      #check
    when "3"
      leaderboard
    when "4"
      view_availible_coins
      pick_coin_to_buy
      #check
    when "5"
      view_account
      pick_coin_to_sell
      #check
    when "6"
      watch_prices
    else
      puts "I'm sorry, I didn't get that."
      account_menu
    end
  end


  def deposit
    puts "Sure thing. How much USD would you like to deposit?"
    response = choices
    usd_amount = handle_choices(response).to_f.round(2)

      if usd_amount > 0
        self.current_user.deposit_usd(usd_amount)
        puts "You just deposited $#{usd_amount}."
        puts "You have $#{self.current_user.bank_account.availible_usd_amount} availible for trading."
        puts "Check out your account below:"
        view_account
      else
        puts "I'm sorry, I didn't get that."
        puts "You need to enter a valid number greater than 0."
        deposit
      end
  end
  #check


  def leaderboard

  end

  def view_availible_coins
    puts "What coins would you like to buy?"
    puts "Here's a list of all the availible coins for sale:"

    Coin.return_current_prices

    # 1. Bitcoin | $11077.2
    # 2. Ethereum | $1040.74
    # 3. Ripple | $1.29972
    # 4. Bitcoin Cash | $1618.5
    # 5. Cardano | $0.62483
    # 6. Litecoin | $178.297
    # 7. Stellar | $0.61065
    # 8. NEM | $0.931868
    # 9. EOS | $13.9
    # 10. NEO | $136.152
  end

########## -------- BUY COIN ---------- #################

  def pick_coin_to_buy
    puts "Enter the name of the coin you'd like to buy:"
    response = choices
    name = handle_choices(response).downcase

    coin = Coin.find_by_name(name)

    if coin
      pick_amount_to_buy(coin)
    else
      puts "I'm sorry, I didn't get that."
      pick_coin_to_buy
    end
  end
  #check


  def pick_amount_to_buy(coin)
    puts "Great! And how much USD worth of #{coin.coin_name} would you like to buy?"
    response = choices
    usd_amount = handle_choices(resp).to_f.round(2)

    if usd_amount > 0
      units = coin.return_units_given_dollars(usd_amount).round(2)
      puts "Awesome! At the current price, you'd get #{units} of #{coin.coin_name} with a total USD cost of $#{usd_amount}."
      complete_purchase(coin.coin_name, usd_amount)
    else
      puts "I'm sorry, I didn't get that. Please enter a positive number."
      pick_amount_to_buy(coin)
    end
  end


  def complete_purchase(name, usd_amount)
    puts "Would you like to complete your purchase? (Y/N)"
    response = choices
    answer = handle_choices(response)

    case answer
    when "y"
      self.current_user.buy_coin(name, usd_amount)
    when "n"
      puts "What would you like to do then?"
      puts "1. Return to main menu. 2. Change USD amount. 3. Change coin. 4. Exit"
      response = gets.chomp.downcase
      case response
      when "1"
        account_menu
      when "2"
        pick_amount_to_buy(name)
      when "3"
        pick_coin_to_buy
      when "4"
        exit_program
      else
        puts "Sorry, I didn't get that."
        complete_purchase(name, usd_amount)
      end
    end
  end

  ########## -------- SELL COIN ---------- #################

  def pick_coin_to_sell
    puts "Enter the name of the coin you'd like to buy:"
    response = choices
    name = handle_choices(response)

    coin = Coin.find_by_name(name)

    if coin
      pick_amount_to_sell(coin)
    else
      puts "I'm sorry, I didn't get that."
      pick_coin_to_sell
    end
  end

  def pick_amount_to_sell(coin)
    puts "Great! And how many units of #{coin.coin_name} would you like to sell?"
    response = choices
    amount_to_sell = handle_choices(resp).to_f

    coin_table_name = self.current_user.bank_account_translator(coin.coin_name)
    Coin.update_coin_prices


    if amount_to_sell < self.current_user.bank_account[coin_table_name]
      usd_amount = amount_to_sell * coin.coin_price
      puts "Awesome! You'd like to sell #{amount_to_sell} #{coin.coin_name} for $#{usd_amount}."
      complete_sale(coin.coin_name, usd_amount)
    else
      puts "I'm sorry, I didn't get that. Please enter a positive number."
      pick_amount_to_sell(coin)
    end
  end

  def complete_sale(coin_name, amount_to_sell)
    puts "Would you like to complete your sale? (Y/N)"
    response = choices
    answer = handle_choices(response)

    case answer
    when "y"
      self.current_user.sell_coin(name, amount_to_sell)
    when "n"
      puts "What would you like to do then?"
      puts "1. Return to main menu. 2. Change amount to sell. 3. Change coin. 4. Exit"
      response = gets.chomp.downcase
      case response
      when "1"
        account_menu
      when "2"
        pick_amount_to_sell(name)
      when "3"
        pick_coin_to_sell
      when "4"
        exit_program
      else
        puts "Sorry, I didn't get that."
        complete_sale(coin_name, amount_to_sell)
      end
    end
  end

  ############################################################


  def exit_program
    abort("Goodby!")
    #end program
  end


end
