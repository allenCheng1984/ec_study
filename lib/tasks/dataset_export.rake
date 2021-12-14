require 'csv'

# 將 product_category 分成六個分類標籤
category_type_label = {
  # 1.時尚配件
  fashio_female_clothing: 1,    #	時尚女性衣服
  fashion_bags_accessories: 1,  #	時尚包包配件
  fashion_childrens_clothes: 1, #	時尚小孩衣服
  fashion_male_clothing: 1,     #	時尚男性衣服
  fashion_shoes: 1,             #	時尚鞋子
  fashion_sport: 1,             #	時尚運動
  fashion_underwear_beach: 1,   #	時尚內衣泳衣
  perfumery: 1,                 #	香水
  watches_gifts: 1,             #	手錶禮物
  luggage_accessories: 1,       #	行李箱配件
  cool_stuff: 1,                #	酷的東西

  # 2.3C用品及小型家電
  dvds_blu_ray: 2,                          #	藍光DVD
  electronics: 2,                           #	電子產品
  computers: 2,                             #	電腦
  computers_accessories: 2,                 #	電腦_配件
  consoles_games: 2,                        #	遊戲機
  home_appliances: 2,                       #	家用電器
  home_appliances_2: 2,                     #	家用電器
  small_appliances: 2,                      #	小家電
  small_appliances_home_oven_and_coffee: 2, #	小家電 烤箱 咖啡機
  telephony: 2,                             #	電話
  air_conditioning: 2,                      #	空調
  tablets_printing_image: 2,                #	印表機平板
  cine_photo: 2,                            #	相機
  fixed_telephony: 2,                       #	固定電話

  # 3.藝文書籍音樂
  books_general_interest: 3, #	一般興趣的書
  books_imported: 3,         #	進口書
  books_technical: 3,        #	科技書
  cds_dvds_musicals: 3,      #	CD DVD 音樂
  music: 3,                  #	音樂
  musical_instruments: 3,    #	樂器
  audio: 3,                  #	聲音
  art: 3,                    #	藝術
  arts_and_craftmanship: 3,  #	藝術與工藝
  flowers: 3,                #	花

  # 4.居家生活及辦公
  furniture_bedroom: 4,                 # 家具床
  furniture_decor: 4,                   # 家具布置
  furniture_living_room: 4,             # 家具客廳
  furniture_mattress_and_upholstery: 4, # 家具床墊室內裝潢
  home_comfort_2: 4,                    # 家_舒適
  home_confort: 4,                      # 家_舒適
  home_construction: 4,                 # 家_施工
  housewares: 4,                        # 家居用品
  kitchen_dining_laundry_garden_furniture: 4, # 廚房洗衣機
  la_cuisine: 4,                        # 廚房料理
  bed_bath_table: 4,                    # 床洗澡桌子
  office_furniture: 4,                  # 辦公家具
  stationery: 4,                        # 文具
  pet_shop: 4,                          # 寵物

  # 5.嬰幼童用品、休閒保健及食品
  diapers_and_hygiene: 5, # 尿布和衛生用品
  baby: 5,                # 嬰兒
  toys: 5,                # 玩具
  christmas_supplies: 5,  # 聖誕用品
  party_supplies: 5,      # 派對用品
  sports_leisure: 5,      # 運動休閒
  health_beauty: 5,       # 美妝保健
  drink: 5,               # 飲料
  food: 5,                # 食物
  food_drink: 5,          # 食物飲料

  # 6.五金工具及其他
  construction_tools_construction: 6, # 建構施工工具
  construction_tools_lights: 6,       # 燈施工工具
  construction_tools_safety: 6,       # 安全施工工具
  costruction_tools_garden: 6,        # 花園施工工具
  costruction_tools_tools: 6,         # 工具施工工具
  garden_tools: 6,                    # 花園工具
  signaling_and_security: 6,          # 施工交通號誌
  security_and_services: 6,           # 安全用品
  auto: 6,                            # 汽車
  agro_industry_and_commerce: 6,      # 農業工業和商業
  industry_commerce_and_business: 6,  # 商業用
  market_place: 6                     # 居家清潔用品
}

namespace :dataset_export do
  # 匯出評價組需要的 dataset 內容
  task :review_team => [ :environment ] do
    puts "#{Time.now} - 開始執行「匯出評價組需要的 dataset 內容」"

    # orders 的篩選條件：
    # 1. 只有一個品項的訂單
    # 2. 有寫評價的訂單
    # 3. 評價分數 3 的排除掉
    orders = Order.where(item_count: 1).where.not(review_score: nil).where.not(review_score: 3)

    dataset = []

    orders.each do |order|
      item  = OrderItem.find_by(order_id: order.order_id)
      product = Product.find_by(product_id: item.product_id)
      # 如果找不到 product / item 資料就排除
      next if !product || !item

      # 只取需要的欄位值進去
      row = {}
      row[:review_score] = order.review_score
      row[:self_defined_review_score] = order.review_type
      row[:seller_state] = order.seller_state_region_type
      row[:delivered_at] = order.order_delivered_customer_date
      row[:approved_at] = order.order_approved_at
      row[:total_shipping_day] = order.total_delivered_waiting_day
      row[:product_id] = product.product_id
      row[:product_category_name_engliah] = product.product_category_name_english
      row[:self_defined_product_category] = category_type_label[order.item_category_name.to_sym]
      row[:item_price] = item.price
      row[:product_length_cm] = product.product_length_cm
      row[:product_height_cm] = product.product_height_cm
      row[:product_width_cm] = product.product_width_cm
      row[:product_weight_g] = product.product_weight_g
      row[:product_volume] = item.package_volume
      row[:approved_waiting_hrs] = order.until_approved_waiting_hours
      row[:seller_to_logistics_hrs] = order.until_approved_waiting_hours
      row[:total_shipping_hrs] = order.total_logistics_using_hours
      row[:seller_lat] = order.seller_geolocation_lat
      row[:seller_lng] = order.seller_geolocation_lng
      row[:geo_distance] = order.geo_distance

      # 存入 dataset
      dataset << row
    end

    # 將整理好的 dataset 轉成 csv
    CSV.open("./tmp/review_dataset.csv", "w", headers: dataset.first.keys, write_headers: true) do |csv|
      dataset.each do |h|
        csv << h.values
      end
    end

    puts "#{Time.now} - 匯出結束"
  end
end
