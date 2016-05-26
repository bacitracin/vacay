class ChangeDataTypeForTrips < ActiveRecord::Migration
  def change
    change_table :trips do |t|
        t.change :start_date, :date 
        t.change :end_date, :date
    end
  end
end
