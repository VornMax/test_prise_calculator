class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :title
      t.string :article
      t.string :brand
      t.text :description
      t.string :image
      t.references :nomenclature_group, foreign_key: true

      t.timestamps
    end
  end
end
