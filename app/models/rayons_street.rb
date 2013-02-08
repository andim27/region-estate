class Rayons_street < ActiveRecord::Base
  # This is map file for real rayons to streets
  belongs_to :rayon
  belongs_to :street
end
