class CreateFallecidos < ActiveRecord::Migration[7.1]
  def change
    create_table :fallecidos do |t|

      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.integer :household_number
      t.integer :death_count
      t.integer :gender_indicator
      t.integer :death_age
      t.integer :certificate_availability
      
      t.timestamps
    end
  end
end
