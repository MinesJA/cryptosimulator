
class BankAccount < ActiveRecord::Base
  belongs_to :user

  def self.bank_account_translator(name)
    case name.downcase
    when "bitcoin"
      "bitcoin_amount"
    when "ethereum"
      "ethereum_amount"
    when "ripple"
      "ripple_amount"
    when "bitcoin cash"
      "bitcoin_cash_amount"
    when "cardano"
      "cardano_amount"
    when "litecoin"
      "litecoin_amount"
    when "stellar"
      "stellar_amount"
    when "nem"
      "nem_amount"
    when "eos"
      "eos_amount"
    when "neo"
      "neo_amount"
    else
      nil
    end
  end

end
