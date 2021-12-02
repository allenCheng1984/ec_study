class AddColumnsToProduct < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :sold_count, :integer, default: 0
    add_column :products, :sold_sum_price, :float, default: 0
    add_column :products, :sold_sum_freight_value, :float, default: 0
    add_column :products, :sold_avg_price, :float, default: 0
    add_column :products, :sold_avg_freight_value, :float, default: 0
    add_column :products, :sold_max_price, :float, default: 0
    add_column :products, :sold_max_freight_value, :float, default: 0
    add_column :products, :sold_min_price, :float, default: 0
    add_column :products, :sold_min_freight_value , :float, default: 0
  end
end
