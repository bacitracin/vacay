class CreateAttractions < ActiveRecord::Migration
  def change
    create_table :attractions do |t|
      t.integer :destination_id
      t.integer :trip_id
      t.string :name
      t.string :url
      t.string :attraction_type

      t.timestamps null: false
    end
  end
end
