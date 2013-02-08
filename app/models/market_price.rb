class MarketPrice < ActiveRecord::Base
  belongs_to :obj
  belongs_to :rayon
end
