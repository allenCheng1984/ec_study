class AddColumnsToOrder4 < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :total_delivered_waiting_day, :float
    add_column :orders, :is_shipping_delayed, :boolean
    add_column :orders, :is_delivered_delayed, :boolean
  end
end
