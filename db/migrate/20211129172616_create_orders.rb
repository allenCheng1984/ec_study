class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.string :customer_id
      t.string :order_status
      t.datetime :order_purchase_timestamp
      t.datetime :order_approved_at
      t.datetime :order_delivered_carrier_date
      t.datetime :order_delivered_customer_date
      t.datetime :order_estimated_delivery_date

      t.timestamps
    end
  end
end
