class AddPackageVolumeToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_column :order_items, :package_volume, :float, default: 0
    add_column :order_items, :package_weight_g, :float, default: 0
  end
end
