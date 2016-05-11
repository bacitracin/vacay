class CreateAttractions < ActiveRecord::Migration
  def change
    create_table :attractions do |t|
      t.integer :destination_id
      t.string :name
      t.string :url
      t.string :attraction_type
      t.integer :trip_attractions

      t.timestamps null: false
    end
  end
end
