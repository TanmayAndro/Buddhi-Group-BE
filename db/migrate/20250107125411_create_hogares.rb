class CreateHogares < ActiveRecord::Migration[7.1]
  def change
    create_table :hogares do |t|

      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.integer :household_number
      t.integer :rooms_count
      t.integer :bedroom_count
      t.integer :kitchen_area
      t.integer :water_source
      t.integer :death_2017
      t.integer :people_count
      
      t.timestamps
    end
  end
end
