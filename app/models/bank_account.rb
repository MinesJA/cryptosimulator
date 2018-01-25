
class BankAccount < ActiveRecord::Base
  belongs_to :user

  def self.bank_account_translator(name)

    case name.downcase
    when "bitcoin"
      "bitcoin_amount"
    when
      
    when
    when
    when
    when
    when
    when
    when
    end
  end

  t.integer "user_id"
  t.float "deposited_usd_amount", default: 0.0
  t.float "availible_usd_amount", default: 0.0
  t.float "bitcoin_amount", default: 0.0
  t.float "ethereum_amount", default: 0.0
  t.float "ripple_amount", default: 0.0
  t.float "bitcoin_cash_amount", default: 0.0
  t.float "cardano_amount", default: 0.0
  t.float "litecoin_amount", default: 0.0
  t.float "stellar_amount", default: 0.0
  t.float "nem_amount", default: 0.0
  t.float "eos_amount", default: 0.0
  t.float "neo_amount", default: 0.0




end
