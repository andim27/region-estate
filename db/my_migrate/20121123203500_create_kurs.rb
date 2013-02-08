class CreateKurs < ActiveRecord::Migration
  def change
    create_table :kurs do |t|
      t.integer :id
      t.string :name
      t.number :kurs_value
      t.timestamps
    end
  end
end
