class CreateRelRayonsAdminStreets < ActiveRecord::Migration
  def change
    create_table :rel_rayons_admin_streets do |t|
      t.integer :id_rayon_admin
      t.integer :id_street_ukr
    end
  end
end
