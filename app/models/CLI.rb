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
      exit
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
      exit
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
      #returns account page
      self.current_user.show_user_balance
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


  def deposit
    puts "Sure thing. How much USD would you like to deposit?"
    usd_amount = gets.chomp
    if usd_amount.downcase == "exit"
      exit
    else
      usd_amount = gets.chomp.to_f.round(2)

      if usd_amount > 0
        self.current_user.deposit_usd(usd_amount)
      else
        puts "I'm sorry, I didn't get that."
        puts "You need to enter a valid number greater than 0."
        deposit
      end
  end


    else
      puts "I'm sorry, I didn't get that. You have to input a number"


  end


  def exit
    puts "Goodbye!"
    #end program
  end







end
