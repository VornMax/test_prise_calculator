class AddContractDiscountToCustomers < ActiveRecord::Migration[7.2]
  def change
    add_column :customers, :contract_discount, :decimal
  end
end
