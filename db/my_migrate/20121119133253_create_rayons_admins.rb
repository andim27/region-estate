class CreateRayonsAdmins < ActiveRecord::Migration
  def change
    create_table :rayons_admins do |t|
      t.integer :id
      t.string :name
      t.integer :city_id

      t.timestamps
    end
  end
end
