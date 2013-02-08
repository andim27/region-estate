class CreateMarketPrices < ActiveRecord::Migration
  def change
    create_table :market_prices do |t|
      t.integer :id
      t.integer :obj_id
      t.integer :room
      t.integer :s_all
      t.integer :rayon_id
      t.decimal :price_min
      t.decimal :price_max
      t.decimal :price
      t.decimal :price_1m2
      t.text   :price_from
      t.decimal :price_1
      t.decimal :price_2
      t.decimal :price_3
      t.decimal :price_4
      t.decimal :price_5
      t.decimal :price_6
      t.decimal :price_7
      t.timestamps
    end
  end
end
