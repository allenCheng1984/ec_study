class AddColumnsToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :order_count, :integer, default: 0
    add_column :customers, :order_sum_price, :float, default: 0
    add_column :customers, :order_sum_freight_value, :float, default: 0
    add_column :customers, :order_avg_price, :float, default: 0
    add_column :customers, :order_avg_freight_value, :float, default: 0
    add_column :customers, :order_max_price, :float, default: 0
    add_column :customers, :order_max_freight_value, :float, default: 0
    add_column :customers, :order_min_price, :float, default: 0
    add_column :customers, :order_min_freight_value, :float, default: 0
  end
end
