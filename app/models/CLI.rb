class CLI
  #include CommandLineReporter
  attr_accessor :current_user

  def initialize
    @current_user = nil
    #current_user is supposed to be a User Instance
  end


  ############-----Gives Option to Quit or Go to Main Menu---------###############

  def choices
    puts ""
    puts ColorizedString["  (Type 'exit' to exit the program or 'menu' to go to the main menu.)"].colorize(:light_white).colorize( :background => :yellow)
    gets.chomp
    #should return response value
  end

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

  ################################################################################

  def self.welcome

  if !User.account_verify("Admin")
    User.create_new_user("Admin")
  end

  puts ""
  puts ColorizedString["                                       Welcome to                                       "].colorize(:light_white).colorize( :background => :blue)

  puts "______                 __             _____ _                 __      __
       / ____/______  ______  / /_____       / ___/(_)___ ___  __  __/ /___ _/ /_____  _____
      / /   / ___/ / / / __ \/ __/ __ \______\__ \/ / __ `__ \/ / / / / __ `/ __/ __ \/ ___/
     / /___/ /  / /_/ / /_/ / /_/ /_/ /_____/__/ / / / / / / / /_/ / / /_/ / /_/ /_/ / /
     \____/_/   \__, / .___/\__/\____/     /____/_/_/ /_/ /_/\__,_/_/\__,_/\__/\____/_/
                /____/_/
      "
  puts ColorizedString["                                                                                         "].colorize(:light_white).colorize( :background => :blue)

  puts ""


    cli = CLI.new
    cli.create_or_sign_in
  end
  #checked


  def create_or_sign_in
    puts ColorizedString[" Would you like to sign in or log in to an existing account?"].colorize(:light_white).colorize( :background => :red)
    puts ColorizedString["    (Choose a number below)    "].colorize(:light_white).colorize( :background => :yellow)
    puts ""

    puts "  1. Create a new account"
    puts "  2. Log in to an existing account"
    puts "  3. Exit"

    puts ""
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

    puts ""

    puts ColorizedString["Great! Let's get you setup."].colorize(:light_white).colorize( :background => :blue)

    puts ""


    puts ColorizedString["What's your name?"].colorize(:light_white).colorize( :background => :red)

    puts ColorizedString["(This will be the name you'll login with in the future)"].colorize(:light_white).colorize( :background => :yellow)

    puts ""

    name = gets.chomp

    if User.account_verify(name)
      puts ""

      puts ColorizedString["I'm sorry, that account already exists."].colorize(:light_white).colorize( :background => :blue)

      puts ""
      create_or_sign_in
    else
      self.current_user = User.create_new_user(name)

      puts ColorizedString["Congratulations, #{name}! You've just created a new account."].colorize(:light_white).colorize( :background => :blue)

      account_menu
    end
  end
  #checked

  def log_out
  end


  def signin
    puts ColorizedString["What's your name?"].colorize(:light_white).colorize( :background => :red)

    name = gets.chomp

    if User.account_verify(name)
      self.current_user = User.user_login(name)

      view_account
      account_menu
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

    #name_header = "#{self.current_user.name}'s Account".colorize(:light_green).on_black


    rows = []
    rows << ["Total Value of Account:", self.current_user.total_value_of_account]
    rows << ["Total Gain/Loss:", "#{self.current_user.total_gain_loss.round(4)}%"]
    table = Terminal::Table.new :title => "#{self.current_user.name}'s Account", :rows => rows, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}

    puts table

    # +------------+--------+
    # | Jonathan's Account  |
    # +------------+--------+
    # | One        | 1      |
    # | Two        | 2      |
    # | Three      | 3      |
    # +------------+--------+

    puts ""
    puts ""

    rows = []
    self.current_user.select_from_balance.each do |key, value|
      rows << ["#{key.upcase.gsub("_", " ")}", value]
    end
    table = Terminal::Table.new :title => "$$$$$ Coin Holdings $$$$$", :headings => ["Coin Name", "Coin Amount"], :rows => rows, :style => {:width => 80, :padding_left => 3, :border_x => "=", :border_i => "x"}
    #table.style = {:width => 40, :padding_left => 3, :border_x => "=", :border_i => "x"}

    puts table

    # +------------+--------+
    # |     Coin Holding    |
    # +------------+--------+
    # | Coin Name  | Coin Am|
    # +------------+--------+
    # | One        | 1      |
    # | Two        | 2      |
    # | Three      | 3      |
    # +------------+--------+


    puts ""
  end

  def account_menu
    puts ColorizedString["    (Choose a number below)    "].colorize(:light_white).colorize( :background => :yellow)

    puts ""

    puts "  1. View Account"
    puts "  2. Deposit USD"
    puts "  3. Buy Coins"
    puts "  4. Sell Coins"
    puts "  5. Watch prices"
    puts "  6. Exit"

    puts ""
    response = gets.chomp

    case response
    when "1"
      view_account
      account_menu
      #check
    when "2"
      deposit
      #check
    when "3"
      view_availible_coins
      pick_coin_to_buy
      #check
    when "4"
      # puts self.current_user.select_from_balance

      #need to format select_from_balance and only return coins (not usd or gains)
      pick_coin_to_sell
      #check
    when "5"
      watch_prices
    when "6"
      exit_program
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
        account_menu
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
  end

  def watch_prices
    Coin.return_current_prices
    account_menu
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
    usd_amount = handle_choices(response).to_f.round(2)

    #this is where you should check to see if you have enough money to complete purchase
    # This file has changed
    if self.current_user.bank_account.availible_usd_amount > usd_amount
      # usd_amount > 0
      units = coin.return_units_given_dollars(usd_amount).round(2)
      puts "Awesome! At the current price, you'd get #{units} of #{coin.coin_name} with a total USD cost of $#{usd_amount}."
      complete_purchase(coin.coin_name, usd_amount, units)
    else
      puts "Insufficient Funds. Please lower your expectations."
      pick_amount_to_buy(coin)
    end
  end


  def complete_purchase(name, usd_amount, unit_amount)
    puts "Would you like to complete your purchase? (Y/N)"
    response = choices
    answer = handle_choices(response)

    case answer.downcase
    when "y"
      # if self.current_user.buy_coin(name, usd_amount)
      #   puts "Insufficient funds. Change the amount to buy."
      #   coin = Coin.find_by_name(name)
      #   pick_amount_to_buy(coin)
      # else
        self.current_user.buy_coin(name, usd_amount)
        puts "Great! Your transaction is confirmed."
        puts "#{unit_amount} #{name} has been added to your account!"
        account_menu
      # end
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
    else
      puts "Sorry, I didn't get that."
      complete_purchase(name, usd_amount)
    end
  end

  ########## -------- SELL COIN ---------- #################

  def pick_coin_to_sell

    puts "Enter the name of the coin you'd like to sell:"
    response = choices
    name = handle_choices(response)

    coin = Coin.find_by_name(name)

    #search for coin before saying "Great!" If user doesn't have coin, say "Sorry"

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
    amount_to_sell = handle_choices(response).to_f

    coin_table_name = BankAccount.bank_account_translator(coin.coin_name)
    Coin.update_coin_prices


    if amount_to_sell < self.current_user.bank_account[coin_table_name]
      usd_amount = amount_to_sell * coin.coin_price
      puts "Awesome! You'd like to sell #{amount_to_sell} #{coin.coin_name} for $#{usd_amount}."
      complete_sale(coin.coin_name, usd_amount)
    else
      puts "Not enough coins. Try again."
      pick_amount_to_sell(coin)
    end
  end

  def complete_sale(coin_name, amount_to_sell)
    puts "Would you like to complete your sale? (Y/N)"
    response = choices
    answer = handle_choices(response)

    case answer
    when "y"
      self.current_user.sell_coin(coin_name, amount_to_sell)
      puts "Great! Your transaction is confirmed."
      puts "You just sold #{amount_to_sell} #{coin_name}."
      account_menu
    when "n"
      puts "What would you like to do then?"
      puts "1. Return to main menu. 2. Change amount to sell. 3. Change coin. 4. Exit"
      response = gets.chomp.downcase
      case response
      when "1"
        account_menu
      when "2"
        coin = Coin.find_by_name(coin_name)
        pick_amount_to_sell(coin)
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
    abort ColorizedString[("                              Goodbye!                         ")].colorize(:light_white).colorize( :background => :blue)
    puts ""
    #end program
  end


end
