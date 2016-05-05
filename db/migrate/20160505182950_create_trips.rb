class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :trip_nickname
      t.string :destination_id
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
  end
end
