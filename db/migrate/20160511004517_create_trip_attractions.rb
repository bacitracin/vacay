class CreateTripAttractions < ActiveRecord::Migration
  def change
    create_table :trip_attractions do |t|
      t.integer :trip_id
      t.integer :attraction_id

      t.timestamps null: false
    end
  end
end
