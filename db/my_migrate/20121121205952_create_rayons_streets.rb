class CreateRayonsStreets < ActiveRecord::Migration
  def change
    create_table :rayons_streets do |t|
      t.integer :rayon_id
      t.integer :street_id
    end
  end
end
