class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.text :destination_id
      t.text :trip_nickname
      t.text :start_date
      t.text :end_date
      t.integer :trip_attractions

      t.timestamps null: false
    end
  end
end
