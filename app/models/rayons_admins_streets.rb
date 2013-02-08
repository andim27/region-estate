class Rayons_admins_street < ActiveRecord::Base
  set_table_name "rayons_admins_streets"
  belongs_to :rayons_admin  #, :foreign_key => :rayons_admins_id
  belongs_to :street #, :foreign_key => :street_id
end
