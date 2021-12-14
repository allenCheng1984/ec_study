class AddColumnsToOrder5 < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :customer_state_region_type, :string
    add_column :orders, :seller_state_region_type, :string
    add_column :orders, :review_type, :boolean
    add_column :orders, :until_approved_waiting_hours, :integer
    add_column :orders, :total_logistics_using_hours, :integer
    add_column :orders, :estimated_logistics_using_hours, :integer
    add_column :orders, :logistics_delay_hours, :integer
  end
end
