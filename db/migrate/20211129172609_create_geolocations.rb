class CreateGeolocations < ActiveRecord::Migration[6.1]
  def change
    create_table :geolocations do |t|
      t.string :geolocation_zip_code_prefix
      t.float :geolocation_lat
      t.float :geolocation_lng
      t.string :geolocation_city
      t.string :geolocation_state

      t.timestamps
    end
  end
end
