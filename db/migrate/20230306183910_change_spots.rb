class ChangeSpots < ActiveRecord::Migration[7.0]
    change_table :spots do |t|
        t.rename :type, :spot_type
    end
end