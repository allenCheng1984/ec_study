class AddGeolocationToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :customer_geolocation_lat, :float
    add_column :customers, :customer_geolocation_lng, :float
  end
end
