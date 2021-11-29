class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.string :order_id
      t.integer :order_item_id
      t.string :product_id
      t.string :seller_id
      t.datetime :shipping_limit_date
      t.float :price
      t.float :freight_value

      t.timestamps
    end
  end
end
