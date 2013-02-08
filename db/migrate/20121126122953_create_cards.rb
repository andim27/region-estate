class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :id
      t.text :text_white
      t.text :text_draft
      t.integer :info_source_id
      t.integer :have_id
      t.timestamps
    end
  end
end
