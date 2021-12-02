class AddColumnsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :item_count, :integer, default: 0
    add_column :orders, :total_item_price, :float, default: 0
    add_column :orders, :payment_count, :integer, default: 0
    add_column :orders, :total_payment_value, :float, default: 0
    add_column :orders, :total_freight_value, :float, default: 0
    add_column :orders, :review_score, :integer, default: 0
    add_column :orders, :review_comment_title, :string, default: ''
    add_column :orders, :review_comment_message, :string, default: ''
    add_column :orders, :review_creation_date, :datetime
    add_column :orders, :review_answer_timestamp, :datetime
    add_column :orders, :review_answer_waiting_hours, :integer, default: 0
    add_column :orders, :customer_city, :string
    add_column :orders, :customer_state, :string
    add_column :orders, :customer_zip_code_prefix, :string
    add_column :orders, :customer_geolocation_lat, :float
    add_column :orders, :customer_geolocation_lng, :float
    add_column :orders, :seller_city, :string
    add_column :orders, :seller_state, :string
    add_column :orders, :seller_zip_code_prefix, :string
    add_column :orders, :seller_geolocation_lat, :float
    add_column :orders, :seller_geolocation_lng, :float
  end
end
