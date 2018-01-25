
class BankAccount < ActiveRecord::Base
  belongs_to :user

  def self.bank_account_translator(name)
    case name.downcase
    when "bitcoin"
      "bitcoin_amount"
    when
      "ethereum_amount"
    when
      "ripple_amount"
    when
      "bitcoin_cash_amount"
    when
      "cardano_amount"
    when
      "litecoin_amount"
    when
      "stellar_amount"
    when
      "nem_amount"
    when
      "eos_amount"
    when
      "neo_amount"
    else
      nil
    end
  end

end
