class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :customer_id
      t.string :customer_unique_id
      t.string :customer_zip_code_prefix
      t.string :customer_city
      t.string :customer_state

      t.timestamps
    end
  end
end
