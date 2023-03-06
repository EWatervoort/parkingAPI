class CreateSpots < ActiveRecord::Migration[7.0]
  def change
    create_table :spots do |t|
      t.string :type
      t.string :taken

      t.timestamps
    end
  end
end
