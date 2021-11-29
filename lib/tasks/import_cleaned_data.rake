require 'csv'

namespace :import_data do
  # 從 csv 檔將企業資料匯入至 DB
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
end
