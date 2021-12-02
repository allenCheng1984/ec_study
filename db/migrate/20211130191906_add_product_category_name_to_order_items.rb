class AddProductCategoryNameToOrderItems < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :product_category_name, :string
  end
end
