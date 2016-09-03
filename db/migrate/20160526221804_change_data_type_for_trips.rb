class ChangeDataTypeForTrips < ActiveRecord::Migration
  def change
    change_table :trips do |t|
        t.change :start_date, :date, 'date USING CAST(start_date AS date)'
        t.change :end_date, :date, 'date USING CAST(start_date AS date)'
    end
  end
end
