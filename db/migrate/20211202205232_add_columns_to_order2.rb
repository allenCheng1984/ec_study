class AddColumnsToOrder2 < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :customer_unique_id, :string
    add_column :orders, :payment_type, :string
    add_column :orders, :payment_sequential, :string
    add_column :orders, :shipping_limit_date, :datetime
    add_column :orders, :order_purchase_year, :integer
    add_column :orders, :order_purchase_month, :integer
    add_column :orders, :order_purchase_year_month, :integer
    add_column :orders, :order_purchase_yearweek, :integer
    add_column :orders, :order_purchase_date, :integer
    add_column :orders, :order_purchase_day, :integer
    add_column :orders, :order_purchase_dayofweek, :integer
    add_column :orders, :order_purchase_hour, :integer
    add_column :orders, :order_purchase_time_day, :string
    add_column :orders, :until_shipped_waiting_hours, :integer, default: 0
    add_column :orders, :until_delivered_waiting_hours, :integer, default: 0
    add_column :orders, :total_package_volume, :float, default: 0
    add_column :orders, :total_package_weight_g, :float, default: 0
    add_column :orders, :delivery_efficiency, :float
    add_column :orders, :item_category_name, :string, default: ''
    add_column :orders, :item_category_count, :integer, default: 0
  end
end
