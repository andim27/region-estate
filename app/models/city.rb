class City < ActiveRecord::Base
  attr_accessible :id, :name, :name_rus, :country
  has_one :rayons_admin
  has_one :rayons
end
