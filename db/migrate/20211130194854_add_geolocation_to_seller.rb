class AddGeolocationToSeller < ActiveRecord::Migration[6.1]
  def change
    add_column :sellers, :seller_geolocation_lat, :float
    add_column :sellers, :seller_geolocation_lng, :float
  end
end
