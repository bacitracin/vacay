class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :destination_id
      t.string :trip_nickname
      t.date :start_date
      t.:date :end_date
      t.integer :trip_attractions

      t.timestamps null: false
    end
  end
end
