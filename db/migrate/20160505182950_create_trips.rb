class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :user_id
<<<<<<< HEAD
      t.string :destination_id
      t.string :trip_nickname
      t.date :start_date
      t.:date :end_date
=======
      t.text :destination_id
      t.text :trip_nickname
      t.text :start_date
      t.text :end_date
>>>>>>> 3877e33c767f26ad0594d4dbcecd559373d9fdae
      t.integer :trip_attractions

      t.timestamps null: false
    end
  end
end
