class CreatePriceRules < ActiveRecord::Migration[7.2]
  def change
    create_table :price_rules do |t|
      t.references :product, foreign_key: true
      t.references :nomenclature_group, foreign_key: true
      t.references :price_group, foreign_key: true
      t.references :customer, foreign_key: true
      t.decimal :original_price, precision: 10, scale: 2
      t.decimal :markup_or_discount, precision: 5, scale: 2
      t.string :rule_type

      t.timestamps
    end
  end
end
