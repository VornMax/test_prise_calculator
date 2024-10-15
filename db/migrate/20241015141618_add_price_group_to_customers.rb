class AddPriceGroupToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_reference :customers, :price_group, foreign_key: true, null: true
  end
end
