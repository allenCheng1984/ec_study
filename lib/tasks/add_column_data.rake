namespace :add_column do

  # 將商品分類名稱存入 order_items
  task :product_category_name_to_order_items => [ :environment ] do
    puts "#{Time.now} - 將商品分類名稱存入 order_items"

    OrderItem.all.each do |item|
      product = Product.find_by(product_id: item.product_id)
      product_name = product ? product.product_category_name_english : ''
      item.update_columns(product_category_name: product_name)
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將地理經緯資訊存入 sellers
  task :geolocation_to_sellers => [ :environment ] do
    puts "#{Time.now} - 將地理經緯資訊存入 sellers"

    Seller.all.each do |seller|
      geolocation = Geolocation.find_by(geolocation_zip_code_prefix: seller.seller_zip_code_prefix)
      seller.update_columns(seller_geolocation_lat: geolocation.geolocation_lat, seller_geolocation_lng: geolocation.geolocation_lng) if geolocation
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將地理經緯資訊存入 customer
  task :geolocation_to_customers => [ :environment ] do
    puts "#{Time.now} - 將地理經緯資訊存入 customer"

    Customer.all.each do |customer|
      geolocation = Geolocation.find_by(geolocation_zip_code_prefix: customer.customer_zip_code_prefix)
      customer.update_columns(customer_geolocation_lat: geolocation.geolocation_lat, customer_geolocation_lng: geolocation.geolocation_lng) if geolocation
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將相關資料存入 orders
  task :more_info_to_orders => [ :environment ] do
    puts "#{Time.now} - 將各總資訊存入 orders"

    Order.all.each do |order|
      items = OrderItem.where(order_id: order.order_id)
      payments = OrderPayment.where(order_id: order.order_id)
      review = OrderReview.find_by(order_id: order.order_id)
      seller = items[0] && Seller.find_by(seller_id: items[0].seller_id)
      customer = Customer.find_by(customer_id: order.customer_id)

      # 將需要的欄位擷取出來
      item_count          = items.size
      payment_count       = payments.size
      total_item_price    = items.pluck(:price).sum
      total_freight_value = items.pluck(:freight_value).sum
      total_payment_value = payments.pluck(:payment_value).sum

      review_score            = review && review.review_score
      review_comment_title    = review && review.review_comment_title || ''
      review_comment_message  = review && review.review_comment_message || ''
      review_creation_date    = review && review.review_creation_date
      review_answer_timestamp = review && review.review_answer_timestamp
      review_answer_waiting_hours = review && ((review_answer_timestamp - review_creation_date) / 1.hour).round

      customer_city            = customer.customer_city
      customer_state           = customer.customer_state
      customer_zip_code_prefix = customer.customer_zip_code_prefix
      customer_geolocation_lat = customer.customer_geolocation_lat
      customer_geolocation_lng = customer.customer_geolocation_lng

      seller_city            = seller && seller.seller_city
      seller_state           = seller && seller.seller_state
      seller_zip_code_prefix = seller && seller.seller_zip_code_prefix
      seller_geolocation_lat = seller && seller.seller_geolocation_lat
      seller_geolocation_lng = seller && seller.seller_geolocation_lng

      # 存入
      order.update_columns(
        item_count: item_count,
        payment_count: payment_count,
        total_item_price: total_item_price,
        total_freight_value: total_freight_value,
        total_payment_value: total_payment_value,
        review_score: review_score,
        review_comment_title: review_comment_title,
        review_comment_message: review_comment_message,
        review_creation_date: review_creation_date,
        review_answer_timestamp: review_answer_timestamp,
        review_answer_waiting_hours: review_answer_waiting_hours,
        customer_city: customer_city,
        customer_state: customer_state,
        customer_zip_code_prefix: customer_zip_code_prefix,
        customer_geolocation_lat: customer_geolocation_lat,
        customer_geolocation_lng: customer_geolocation_lng,
        seller_city: seller_city,
        seller_state: seller_state,
        seller_zip_code_prefix: seller_zip_code_prefix,
        seller_geolocation_lat: seller_geolocation_lat,
        seller_geolocation_lng: seller_geolocation_lng
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將各總資訊存入 products
  task :more_info_to_products => [ :environment ] do
    puts "#{Time.now} - 將各總資訊存入 products"

    Product.all.each do |product|
      prices   = OrderItem.where(product_id: product.product_id).pluck(:price)
      freights = OrderItem.where(product_id: product.product_id).pluck(:freight_value)

      # 將需要的欄位擷取出來
      sold_count             = prices.size
      sold_sum_price         = prices.sum.round(2)
      sold_sum_freight_value = freights.sum.round(2)
      sold_avg_price         = (sold_sum_price / sold_count).round(2)
      sold_avg_freight_value = (sold_sum_freight_value / sold_count).round(2)
      sold_max_price         = prices.max.round(2)
      sold_max_freight_value = freights.max.round(2)
      sold_min_price         = prices.min.round(2)
      sold_min_freight_value = freights.max.round(2)

      # 存入
      product.update_columns(
        sold_count: sold_count,
        sold_sum_price: sold_sum_price,
        sold_sum_freight_value: sold_sum_freight_value,
        sold_avg_price: sold_avg_price,
        sold_avg_freight_value: sold_avg_freight_value,
        sold_max_price: sold_max_price,
        sold_max_freight_value: sold_max_freight_value,
        sold_min_price: sold_min_price,
        sold_min_freight_value: sold_min_freight_value
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將各總資訊存入 sellers
  task :more_info_to_sellers => [ :environment ] do
    puts "#{Time.now} - 將各總資訊存入 sellers"

    Seller.all.each do |seller|
      prices = Order.where(seller_id: seller.seller_id).pluck(:total_item_price)
      freights = Order.where(seller_id: seller.seller_id).pluck(:total_freight_value)

      next if prices.length === 0

      order_count             = prices.size
      order_sum_price         = prices.sum.round(2)
      order_sum_freight_value = freights.sum.round(2)
      order_avg_price         = (order_sum_price / order_count).round(2)
      order_avg_freight_value = (order_sum_freight_value / order_count).round(2)
      order_max_price         = prices.max.round(2)
      order_max_freight_value = freights.max.round(2)
      order_min_price         = prices.min.round(2)
      order_min_freight_value = freights.max.round(2)

      seller.update_columns(
        order_count: order_count,
        order_sum_price: order_sum_price,
        order_sum_freight_value: order_sum_freight_value,
        order_avg_price: order_avg_price,
        order_avg_freight_value: order_avg_freight_value,
        order_max_price: order_max_price,
        order_max_freight_value: order_max_freight_value,
        order_min_price: order_min_price,
        order_min_freight_value: order_min_freight_value
      )
    end


    puts "#{Time.now} - 匯入結束"
  end

  # 將各總資訊存入 customers
  task :more_info_to_customers => [ :environment ] do
    puts "#{Time.now} - 將各總資訊存入 customers"

    Customer.all.each do |customer|
      prices = Order.where(customer_id: customer.customer_id).pluck(:total_item_price)
      freights = Order.where(customer_id: customer.customer_id).pluck(:total_freight_value)

      order_count             = prices.size
      order_sum_price         = prices.sum.round(2)
      order_sum_freight_value = freights.sum.round(2)
      order_avg_price         = (order_sum_price / order_count).round(2)
      order_avg_freight_value = (order_sum_freight_value / order_count).round(2)
      order_max_price         = prices.max.round(2)
      order_max_freight_value = freights.max.round(2)
      order_min_price         = prices.min.round(2)
      order_min_freight_value = freights.max.round(2)

      customer.update_columns(
        order_count: order_count,
        order_sum_price: order_sum_price,
        order_sum_freight_value: order_sum_freight_value,
        order_avg_price: order_avg_price,
        order_avg_freight_value: order_avg_freight_value,
        order_max_price: order_max_price,
        order_max_freight_value: order_max_freight_value,
        order_min_price: order_min_price,
        order_min_freight_value: order_min_freight_value
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將 package_volume & package_weight_g 存入 order_items
  task :package_info_to_order_items => [ :environment ] do
    puts "#{Time.now} - 將 package_volume 存入 order_items"

    OrderItem.all.each do |order_item|
      product = Product.find_by(product_id: order_item.product_id)
      next if product.blank?

      length = product.product_length_cm
      height = product.product_height_cm
      width = product.product_width_cm
      next if !(length && height && width)

      package_volume = length * width * length
      package_weight_g = product.product_weight_g

      order_item.update_columns(
        package_volume: package_volume,
        package_weight_g: package_weight_g
      )
    end

    puts "#{Time.now} - 匯入結束"
  end

  # 將更多欄位存入 orders 裡面
  task :more_info_to_orders2 => [ :environment ] do
    puts "#{Time.now} - 將更多欄位存入 orders 裡面"

    Order.all.each do |order|
      items = OrderItem.where(order_id: order.order_id).order(shipping_limit_date: :desc)
      customer = Customer.find_by(customer_id: order.customer_id)
      payments = OrderPayment.where(order_id: order.order_id)
      review = OrderReview.find_by(order_id: order.order_id)

      purchase_at = order.order_purchase_timestamp
      approved_at = order.order_approved_at
      shipped_at = order.order_delivered_carrier_date
      delivered_at = order.order_delivered_customer_date
      estimated_at = order.order_estimated_delivery_date
      estimated_hour = (estimated_at.present? && purchase_at.present?) && ((estimated_at - purchase_at) / 1.hour).round

      # 將需要的欄位存入進去
      seller_id                     = items[0] && items[0].seller_id
      customer_unique_id            = customer && customer.customer_unique_id
      payment_type                  = payments && payments.map{|p| p.payment_type }.uniq.join(',')
      payment_sequential            = payments && payments.map{|p| p.payment_sequential }.sort.join(',')
      shipping_limit_date           = items[0] && items[0].shipping_limit_date
      order_purchase_year           = purchase_at.year # 2017
      order_purchase_month          = purchase_at.month # 1 ~ 12
      order_purchase_year_month     = purchase_at.strftime("%Y%m").to_i # (201701~201712)
      order_purchase_yearweek       = purchase_at.strftime("%Y%W").to_i # (201700 ~201752)
      order_purchase_date           = purchase_at.strftime("%Y%m%d").to_i # (20170101)
      order_purchase_day            = purchase_at.strftime("%d").to_i # (0~31)
      order_purchase_dayofweek      = purchase_at.strftime("%w").to_i # (0 ~ 6)
      order_purchase_hour           = purchase_at.strftime("%H").to_i # (0 ~ 24)
      order_purchase_time_day       = case order_purchase_hour # (dawn, morning, afternoon, night)
                                      when 0..5
                                        'dawn'
                                      when 6..11
                                        'morning'
                                      when 12..18
                                        'afternoon'
                                      when 19..23
                                        'night'
                                      end

      until_shipped_waiting_hours   = (approved_at.present? && shipped_at.present?) && ((shipped_at - approved_at) / 1.hour).round
      until_delivered_waiting_hours = (shipped_at.present? && delivered_at.present?) && ((delivered_at - shipped_at) / 1.hour).round
      delivery_efficiency           = (until_shipped_waiting_hours && until_delivered_waiting_hours && estimated_hour) && (1 - ( (until_shipped_waiting_hours + until_delivered_waiting_hours) / estimated_hour.to_f).round(2))
      total_package_volume          = items && items.map{|item| item.package_volume }.sum
      total_package_weight_g        = items && items.map{|item| item.package_weight_g }.sum
      item_category_name            = items && items.map{|item| item.product_category_name }.uniq.join(',')
      item_category_count           = items && items.map{|item| item.product_category_name }.uniq.size

      order.update_columns(
        seller_id: seller_id,
        customer_unique_id: customer_unique_id,
        payment_type: payment_type,
        payment_sequential: payment_sequential,
        shipping_limit_date: shipping_limit_date,
        order_purchase_year: order_purchase_year,
        order_purchase_month: order_purchase_month,
        order_purchase_year_month: order_purchase_year_month,
        order_purchase_yearweek: order_purchase_yearweek,
        order_purchase_date: order_purchase_date,
        order_purchase_day: order_purchase_day,
        order_purchase_dayofweek: order_purchase_dayofweek,
        order_purchase_hour: order_purchase_hour,
        order_purchase_time_day: order_purchase_time_day,
        until_shipped_waiting_hours: until_shipped_waiting_hours,
        until_delivered_waiting_hours: until_delivered_waiting_hours,
        total_package_volume: total_package_volume,
        total_package_weight_g: total_package_weight_g,
        delivery_efficiency: delivery_efficiency,
        item_category_name: item_category_name,
        item_category_count: item_category_count
      )
    end

    puts "#{Time.now} - 匯入結束"
  end
end
