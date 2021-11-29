class CreateOrderReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :order_reviews do |t|
      t.string :review_id
      t.string :order_id
      t.string :review_score
      t.string :review_comment_title
      t.string :review_comment_message
      t.datetime :review_creation_date
      t.datetime :review_answer_timestamp

      t.timestamps
    end
  end
end
