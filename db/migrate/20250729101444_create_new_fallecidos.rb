class CreateNewFallecidos < ActiveRecord::Migration[7.1]
  def change
    create_table :new_fallecidos do |t|
      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.integer :household_number
      t.integer :death_count
      t.integer :gender_indicator
      t.integer :death_age
      t.integer :certificate_availability
      t.integer :type_of_record
      t.integer :survey_code 
      t.integer :housing_unit
      t.string :common_key  

      t.timestamps
    end
  end
end
