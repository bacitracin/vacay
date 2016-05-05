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
