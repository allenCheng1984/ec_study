class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :product_id
      t.string :product_category_name
      t.string :product_category_name_english
      t.float :product_name_lenght
      t.float :product_description_lenght
      t.float :product_photos_qty
      t.float :product_weight_g
      t.float :product_length_cm
      t.float :product_height_cm
      t.float :product_width_cm

      t.timestamps
    end
  end
end
