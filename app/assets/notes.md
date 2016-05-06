notes.md

class CreateAttractions < ActiveRecord::Migration
  def change
    create_table :attractions do |t|
      t.integer :trip_id
      t.integer :destination_id
      t.string :attraction_type
      t.string :url
      t.string :description

      t.timestamps null: false
    end
  end
end

class Attraction < ActiveRecord::Base
  belongs_to :destination
  belongs_to :trip
  has_many :reviews
end


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

class Review < ActiveRecord::Base
  belongs_to :attraction
end


params = {
  :destination => {
    :city => "Charlotte"
  }
  :trip => {
    :trip_nickname => "Southern Charm",
    :start_date => "10/10/16",
    :end_date => "10/15/16"
  }
}
