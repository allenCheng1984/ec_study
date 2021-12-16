class AddColumnsToOrder6 < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :review_product_id, :string
    add_column :orders, :review_product_category_name_engliah, :string
    add_column :orders, :review_item_price, :float
    add_column :orders, :review_product_length_cm, :float
    add_column :orders, :review_product_height_cm, :float
    add_column :orders, :review_product_width_cm, :float
    add_column :orders, :review_product_weight_g, :float
    add_column :orders, :review_product_volume, :float
  end
end
