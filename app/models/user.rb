class User < ActiveRecord::Base
  has_many :coin_transactions
  has_many :usd_transactions
  has_many :coins, through: :coin_transactions
end
