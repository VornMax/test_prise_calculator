class CreateNomenclatureGroups < ActiveRecord::Migration[7.2]
  def change
    create_table :nomenclature_groups do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end
  end
end
