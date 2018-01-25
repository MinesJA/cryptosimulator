class CLI

  def welcome
    puts "Welcome to CryptoSimulator!"
    create_or_sign_in
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
    new_user = {}

    puts "Great! Let's get you setup."

    puts "What's your name?"
    puts "(This will be the name you'll login with in the future)"
    new_user[:name] = gets.chomp

    #puts "Choose a new password:"
    #new_user[:password] = gets.chomp

    # puts "How old are you?"
    # new_user[:age] = gets.chomp
    #
    # puts "What country are you living in?"
    # new_user[:country] = gets.chomp

    self.current_user = User.create_new_user(new_user)
    account_menu
  end

  def signin
    return_user = {}

    puts "Whats your name?"
    name = gets.chomp

    if self.account_verify(name)
      return_user[:name] = name

      puts "Welcome back, #{name}!"
      # puts "what's your password?"
      # password = gets.chomp
      # verify_password
      self.user_login(name)
      account_menu
    else
      no_matching_username
    end
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






  def exit
    puts "Goodbye!"
    #end program
  end







end
