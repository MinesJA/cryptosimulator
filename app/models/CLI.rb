


class CLI

  def welcome
    puts "Welcome to CryptoSimulator!"
    create_or_sign_in
  end

  def create_or_sign_in
    puts "Would you like to sign in or log in to an existing account?"
    puts "1. Create a new account. 2. Log in to an existing account. 3. Exit."
    response = gets.chomp

    case response
    when "1"
      create_new_account
    when "2"
      log_in
    when "3"
      exit
    else
      puts "I'm sorry, I didn't get that."
      create_or_sign_in
    end

  def create_new_account
    new_user = {}

    puts "Great! Let's start with some information about."

    puts "What's your name?"
    new_user[:name] = gets.chomp

    puts "How old are you?"
    new_user[:age] = gets.chomp

    puts "What country are you living in?"
    new_user[:country] = gets.chomp

    self.
  end


  def create_trainer
      trainer ={}
      puts "What is your name?"
      trainer[:name] = gets.chomp
      puts "what town are you from?"
      trainer[:town] = gets.chomp
      self.current_user = Trainer.find_or_create_by(trainer)
      trainer_choices
end





#1. Welcome
#2.
