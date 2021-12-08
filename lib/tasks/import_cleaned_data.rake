require 'csv'

namespace :import_data do
  # 從 csv 檔將消費者資料匯入至 DB
  task :customers => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_customers_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_customers_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      Customer.create(
        customer_id: row[0],
        customer_unique_id: row[1],
        customer_zip_code_prefix: row[2],
        customer_city: row[3],
        customer_state: row[4]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將賣家資料匯入至 DB
  task :sellers => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_sellers_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_sellers_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      Seller.create(
        seller_id: row[0],
        seller_zip_code_prefix: row[1],
        seller_city: row[2],
        seller_state: row[3]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將地理資料資料匯入至 DB
  task :geolocations => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_geolocation_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_geolocation_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      Geolocation.create(
        geolocation_zip_code_prefix: row[0],
        geolocation_lat: row[1],
        geolocation_lng: row[2],
        geolocation_city: row[3],
        geolocation_state: row[4]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將訂單資料匯入至 DB
  task :orders => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_orders_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_orders_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      Order.create(
        order_id: row[0],
        customer_id: row[1],
        order_status: row[2],
        order_purchase_timestamp: row[3],
        order_approved_at: row[4],
        order_delivered_carrier_date: row[5],
        order_delivered_customer_date: row[6],
        order_estimated_delivery_date: row[7]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將訂單品項資料匯入至 DB
  task :order_items => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_order_items_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_order_items_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      OrderItem.create(
        order_id: row[0],
        order_item_id: row[1],
        product_id: row[2],
        seller_id: row[3],
        shipping_limit_date: row[4],
        price: row[5],
        freight_value: row[6]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將訂單支付資料匯入至 DB
  task :order_payments => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_order_payments_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_order_payments_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      OrderPayment.create(
        order_id: row[0],
        payment_sequential: row[1],
        payment_type: row[2],
        payment_installments: row[3],
        payment_value: row[4]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將訂單評論資料匯入至 DB
  task :order_reviews => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_order_reviews_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_order_reviews_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      OrderReview.create(
        review_id: row[0],
        order_id: row[1],
        review_score: row[2],
        review_comment_title: row[3],
        review_comment_message: row[4],
        review_creation_date: row[5],
        review_answer_timestamp: row[6]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將商品資料匯入至 DB
  task :products => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_products_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_products_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      Product.create(
        product_id: row[0],
        product_category_name: row[1],
        product_name_lenght: row[2],
        product_description_lenght: row[3],
        product_photos_qty: row[4],
        product_weight_g: row[5],
        product_length_cm: row[6],
        product_height_cm: row[7],
        product_width_cm: row[8],
        product_category_name_english: row[9]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 從 csv 檔將 marketing_qualified_leads (有效潛在客戶) 資料匯入至 DB
  task :marketing_qualified_leads => [ :environment ] do
    puts "#{Time.now} - 開始從 olist_marketing_qualified_leads_dataset.csv 匯入消費者資料"
    dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_marketing_qualified_leads_dataset.csv")
    rows = CSV.parse(dataset_text)

    rows.drop(1).each do |row|
      MarketingQualifiedLead.create(
        mql_id: row[0],
        first_contact_date: row[1],
        landing_page_id: row[2],
        origin: row[3]
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

    # 從 csv 檔將 closed_deals (有效潛在客戶) 資料匯入至 DB
    task :closed_deals => [ :environment ] do
      puts "#{Time.now} - 開始從 olist_closed_deals_dataset.csv 匯入消費者資料"
      dataset_text = File.read("#{Rails.root}/lib/cleaned_data/olist_closed_deals_dataset.csv")
      rows = CSV.parse(dataset_text)

      rows.drop(1).each do |row|
        ClosedDeal.create(
          mql_id: row[0],
          seller_id: row[1],
          sdr_id: row[2],
          sr_id: row[3],
          won_date: row[4],
          business_segment: row[5],
          lead_type: row[6],
          lead_behaviour_profile: row[7],
          has_company: ActiveModel::Type::Boolean.new.cast(row[8]),
          has_gtin: ActiveModel::Type::Boolean.new.cast(row[9]),
          average_stock: row[10],
          business_type: row[11],
          declared_product_catalog_size: row[12],
          declared_monthly_revenue: row[13]
        )
      end

      puts "#{Time.now} - 匯入結束"
    end
end
