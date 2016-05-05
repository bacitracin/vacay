class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :review_title
      t.integer :rating
      t.text :review
      t.integer :attraction_id

      t.timestamps null: false
    end
  end
end
