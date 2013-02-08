class Obj < ActiveRecord::Base
  has_one :have
  has_many :market_prices
end
