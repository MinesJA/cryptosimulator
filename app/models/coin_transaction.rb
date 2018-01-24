class CoinTransaction < ActiveRecord::Base
  belongs_to :users
  belongs_to :coins
end
