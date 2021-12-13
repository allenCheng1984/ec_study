class AddGeoDistanceToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :geo_distance, :float
  end
end
