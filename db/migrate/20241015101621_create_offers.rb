class CreateOffers < ActiveRecord::Migration[7.2]
  def change
    create_table :offers do |t|
      t.references :product, foreign_key: true
      t.decimal :price, precision: 10, scale: 2
      t.integer :delivery_date
      t.jsonb :bonuses
      t.integer :stock

      t.timestamps
    end
  end
end
