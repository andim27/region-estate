class Street < ActiveRecord::Base
   #set_table_name "kharkov_streets_ukrs"
   attr_accessible :id, :name, :name_rus, :center_lat, :center_lng
   #has_many :rel_rayons_admins_streets_ukrs
   #has_many :rayons_admins, :through => :rel_rayons_admins_streets_ukrs
    has_and_belongs_to_many :rayons_admins
    has_and_belongs_to_many :rayons
    has_one :have
end
