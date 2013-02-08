class CreateDopParams < ActiveRecord::Migration
  def change
    create_table :dop_params do |t|
      t.integer :id
      t.integer :parent
      t.string :name
      t.text :fields_list

      t.timestamps
    end
  end
end
