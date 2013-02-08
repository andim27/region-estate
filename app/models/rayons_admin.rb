class RayonsAdmin < ActiveRecord::Base
  self.table_name = "rayons_admins"
  ##attr_accessible :id, :name, :city_id
  belongs_to :city
  #has_many :rel_rayons_admins_streets_ukrs
  #has_many :streets, :through =>:rel_rayons_admins_streets_ukrs
  has_and_belongs_to_many :streets
end
