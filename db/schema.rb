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

ActiveRecord::Schema.define(version: 2021_11_29_172634) do

  create_table "customers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "customer_id"
    t.string "customer_unique_id"
    t.string "customer_zip_code_prefix"
    t.string "customer_city"
    t.string "customer_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
  end

  create_table "sellers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "seller_id"
    t.string "seller_zip_code_prefix"
    t.string "seller_city"
    t.string "seller_state"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
