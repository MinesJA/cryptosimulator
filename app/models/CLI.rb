class CLI
  attr_accessor :current_user

  def initialize
    @current_user = nil
    #current_user is supposed to be a User Instance
  end


  def self.welcome
    puts "Welcome to CryptoSimulator!"
    cli = CLI.new
    cli.create_or_sign_in
  end


  def create_or_sign_in
    puts "Would you like to sign in or log in to an existing account?"
    puts "Enter the number associated with your choice below:"
    puts "1. Create a new account. 2. Log in to an existing account. 3. Exit."
    response = gets.chomp

    case response
    when "1"
      create_account
    when "2"
      signin
    when "3"
      exit_program
    else
      puts "I'm sorry, I didn't get that."
      create_or_sign_in
    end
  end


  def create_account
    #new_user = {}

    puts "Great! Let's get you setup."

    puts "What's your name?"
    puts "(This will be the name you'll login with in the future)"
    name = gets.chomp

    if User.account_verify(name)
      puts "I'm sorry, that account already exists."
      puts "What would you like to do?"
      create_or_sign_in
    else
      self.current_user = User.create_new_user(name)
      account_menu
    end

    #puts "Choose a new password:"
    #new_user[:password] = gets.chomp

    # puts "How old are you?"
    # new_user[:age] = gets.chomp
    #
    # puts "What country are you living in?"
    # new_user[:country] = gets.chomp
  end


  def signin
    puts "Whats your name?"
    name = gets.chomp

    if User.account_verify(name)
      # puts "what's your password?"
      # password = gets.chomp
      # verify_password
      self.current_user = User.user_login(name)
      puts "Welcome back, #{name}!"
      binding.pry
      account_menu
    else
      no_matching_username
    end
  end

  def create_or_sign_in
    puts "Would you like to sign in or log in to an existing account?"

    puts "1. Create a new account. 2. Log in to an existing account. 3. Exit."
    response = gets.chomp
  end


  def no_matching_username
    puts "I'm sorry, we couldn't find that username."
    puts "What would you like to do?"
    puts "1. Try a different username. 2. Create a new user. 3. Exit."
    response = gets.chomp

    case response
    when "1"
      signin
    when "2"
      create_account
    when "3"
      exit_program
    else
      puts "I'm sorry, I didn't get that."
      signin
    end
  end


  def account_menu
    puts "What would you like to do, #{self.current_user.name}"
    puts "Enter the number associated with your choice below:"
    puts "1. View Account. 2. Deposit USD. 3. See leaderboard. 4. Buy coins. 5. Sell Coins. 6. Watch prices. 7. Exit "

    response = gets.chomp

    case response
    when "1"
      view_account
    when "2"
      deposit
    when "3"
      leaderboard
    when "4"
      buy_coins
    when "5"
      sell_coins
    when "6"
      watch_prices
    else
      puts "I'm sorry, I didn't get that."
      account_menu
    end
  end


  def view_account
    self.current_user.show_user_balance

    puts "What would you like to do now?"
    puts "Enter the number associated with your choice below:"
    puts "1. Go back to main menu. 2. Exit."
    response = gets.chomp

    case response
    when "1"
      account_menu
    when "2"
      exit_program
    else
      puts "I'm sorry, I didn't get that."
    end
  end


  def deposit
    puts "Sure thing. How much USD would you like to deposit?"
    puts "You can else enter 'exit' to exit the program, or 'menu' to go back to the main menu."
    usd_amount = gets.chomp

    if usd_amount.downcase == "exit"
      exit_program
    elsif usd_amount.downcase == "menu"
      account_menu
    else
      usd_amount = gets.chomp.to_f.round(2)

      if usd_amount > 0
        self.current_user.deposit_usd(usd_amount)
        puts "You just deposited $#{usd_amount}."
        puts "You have $#{self.current_user.bank_account.availible_usd_amount} availible for trading."
        account_menu
      else
        puts "I'm sorry, I didn't get that."
        puts "You need to enter a valid number greater than 0."
        deposit
      end
    end
  end

  def leaderboard

  end

  def buy_coins
    puts "What coins would you like to buy?"
    sleep 1

    puts "Here's a list of all the availible coins for sale:"
    sleep 1

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

    sleep 1

    puts "Enter the corresponding number for the coin you'd like to buy:"
    puts "You can also type 'exit' or 'menu' to exit the program or get back to the main menu."
    coin = gets.chomp.downcase

    case coin
    when "1"
      name = "bitcoin"
    when "2"
      name = "ethereum"
    when "3"
      name = "ripple"
    when "4"
      name = "bitcoin cash"
    when "5"
      name = "cardano"
    when "6"
      name = "litecoin"
    when "7"
      name = "stellar"
    when "8"
      name = "nem"
    when "9"
      name = "eos"
    when "10"
      name = "neo"
    when "exit"
      exit_program
    when "menu"
      account_menu
    else
      puts "I'm sorry, I didn't get that."
      buy_coins
    end



    self.current_user.buy_coin("Bitcoin", )




  end



  def exit_program
    puts "Goodbye!"
    #end program
  end







end
