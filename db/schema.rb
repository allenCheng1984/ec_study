# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_02_210528) do

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "customer_id"
    t.string "customer_unique_id"
    t.string "customer_zip_code_prefix"
    t.string "customer_city"
    t.string "customer_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "customer_geolocation_lat"
    t.float "customer_geolocation_lng"
    t.integer "order_count", default: 0
    t.float "order_sum_price", default: 0.0
    t.float "order_sum_freight_value", default: 0.0
    t.float "order_avg_price", default: 0.0
    t.float "order_avg_freight_value", default: 0.0
    t.float "order_max_price", default: 0.0
    t.float "order_max_freight_value", default: 0.0
    t.float "order_min_price", default: 0.0
    t.float "order_min_freight_value", default: 0.0
  end

  create_table "geolocations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "geolocation_zip_code_prefix"
    t.float "geolocation_lat"
    t.float "geolocation_lng"
    t.string "geolocation_city"
    t.string "geolocation_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_items", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.integer "order_item_id"
    t.string "product_id"
    t.string "seller_id"
    t.datetime "shipping_limit_date"
    t.float "price"
    t.float "freight_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "product_category_name"
    t.float "package_volume", default: 0.0
    t.float "package_weight_g", default: 0.0
  end

  create_table "order_payments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.integer "payment_sequential"
    t.string "payment_type"
    t.integer "payment_installments"
    t.float "payment_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_reviews", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "review_id"
    t.string "order_id"
    t.string "review_score"
    t.string "review_comment_title"
    t.string "review_comment_message"
    t.datetime "review_creation_date"
    t.datetime "review_answer_timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "order_id"
    t.string "customer_id"
    t.string "order_status"
    t.datetime "order_purchase_timestamp"
    t.datetime "order_approved_at"
    t.datetime "order_delivered_carrier_date"
    t.datetime "order_delivered_customer_date"
    t.datetime "order_estimated_delivery_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "item_count", default: 0
    t.float "total_item_price", default: 0.0
    t.integer "payment_count", default: 0
    t.float "total_payment_value", default: 0.0
    t.float "total_freight_value", default: 0.0
    t.integer "review_score", default: 0
    t.string "review_comment_title", default: ""
    t.string "review_comment_message", default: ""
    t.datetime "review_creation_date"
    t.datetime "review_answer_timestamp"
    t.integer "review_answer_waiting_hours", default: 0
    t.string "customer_city"
    t.string "customer_state"
    t.string "customer_zip_code_prefix"
    t.float "customer_geolocation_lat"
    t.float "customer_geolocation_lng"
    t.string "seller_city"
    t.string "seller_state"
    t.string "seller_zip_code_prefix"
    t.float "seller_geolocation_lat"
    t.float "seller_geolocation_lng"
    t.string "seller_id"
    t.string "customer_unique_id"
    t.string "payment_type"
    t.string "payment_sequential"
    t.datetime "shipping_limit_date"
    t.integer "order_purchase_year"
    t.integer "order_purchase_month"
    t.integer "order_purchase_year_month"
    t.integer "order_purchase_yearweek"
    t.integer "order_purchase_date"
    t.integer "order_purchase_day"
    t.integer "order_purchase_dayofweek"
    t.integer "order_purchase_hour"
    t.string "order_purchase_time_day"
    t.integer "until_shipped_waiting_hours", default: 0
    t.integer "until_delivered_waiting_hours", default: 0
    t.float "total_package_volume", default: 0.0
    t.float "total_package_weight_g", default: 0.0
    t.float "delivery_efficiency"
    t.string "item_category_name", default: ""
    t.integer "item_category_count", default: 0
  end

  create_table "products", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "product_id"
    t.string "product_category_name"
    t.string "product_category_name_english"
    t.float "product_name_lenght"
    t.float "product_description_lenght"
    t.float "product_photos_qty"
    t.float "product_weight_g"
    t.float "product_length_cm"
    t.float "product_height_cm"
    t.float "product_width_cm"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sold_count", default: 0
    t.float "sold_sum_price", default: 0.0
    t.float "sold_sum_freight_value", default: 0.0
    t.float "sold_avg_price", default: 0.0
    t.float "sold_avg_freight_value", default: 0.0
    t.float "sold_max_price", default: 0.0
    t.float "sold_max_freight_value", default: 0.0
    t.float "sold_min_price", default: 0.0
    t.float "sold_min_freight_value", default: 0.0
  end

  create_table "sellers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "seller_id"
    t.string "seller_zip_code_prefix"
    t.string "seller_city"
    t.string "seller_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "seller_geolocation_lat"
    t.float "seller_geolocation_lng"
    t.integer "order_count", default: 0
    t.float "order_sum_price", default: 0.0
    t.float "order_sum_freight_value", default: 0.0
    t.float "order_avg_price", default: 0.0
    t.float "order_avg_freight_value", default: 0.0
    t.float "order_max_price", default: 0.0
    t.float "order_max_freight_value", default: 0.0
    t.float "order_min_price", default: 0.0
    t.float "order_min_freight_value", default: 0.0
  end

end
