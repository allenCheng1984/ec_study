class CreateSellers < ActiveRecord::Migration[6.1]
  def change
    create_table :sellers do |t|
      t.string :seller_id
      t.string :seller_zip_code_prefix
      t.string :seller_city
      t.string :seller_state

      t.timestamps
    end
  end
end
