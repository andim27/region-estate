class CreateRayons < ActiveRecord::Migration
  def change
    create_table :rayons do |t|
      t.integer :id
      t.parent :id
      t.string :name
      t.integer :city_id
      t.integer :level

      t.timestamps
    end
  end
end
