class AddColumnToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :price, :decimal, precision: 8, scale: 2, null: false
  end
end
