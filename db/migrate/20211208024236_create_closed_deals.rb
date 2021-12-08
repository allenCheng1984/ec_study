class CreateClosedDeals < ActiveRecord::Migration[6.1]
  def change
    create_table :closed_deals do |t|
      t.string :mql_id
      t.string :seller_id
      t.string :sdr_id
      t.string :sr_id
      t.date :won_date
      t.string :business_segment
      t.string :lead_type
      t.string :lead_behaviour_profile
      t.boolean :has_company
      t.boolean :has_gtin
      t.string :average_stock
      t.string :business_type
      t.float :declared_product_catalog_size
      t.float :declared_monthly_revenue, default: 0

      t.timestamps
    end
  end
end
