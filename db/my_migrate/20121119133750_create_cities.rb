class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.integer :id
      t.string :name
      t.string :name_rus
      t.string :country

      t.timestamps
    end
  end
end
