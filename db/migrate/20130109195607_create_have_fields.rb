class CreateHaveFields < ActiveRecord::Migration
  def change
    create_table :have_fields do |t|
      t.integer :id
      t.string :name
      t.string :field_name
      t.string :field_type
      t.string :field_ui_type
      t.string :field_ds
    end
  end
end
