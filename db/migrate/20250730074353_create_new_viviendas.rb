class CreateNewViviendas < ActiveRecord::Migration[7.1]
  def change
    create_table :new_viviendas do |t|
      t.integer :department_code
      t.integer :muncipality_code
      t.integer :unit_info
      t.boolean :ethnic_territory
      t.integer :ethnic_territory_type
      t.integer :ethnic_territory_code
      t.integer :is_protected_area
      t.integer :home_usage
      t.integer :house_type
      t.integer :houses_occupation
      t.integer :number_of_homes
      t.integer :contruction_material
      t.boolean :electricity_availability
      t.integer :socioeconomic_status
      t.boolean :aquaduct_availability
      t.boolean :sewe_availability
      t.integer :gas_availability
      t.integer :garbage_disposability
      t.integer :disposal_frequency
      t.boolean :internet_availability
      t.integer :sanitory_quality
      t.integer :house_category
      t.integer :home_availability
      t.integer :resident_number
      t.integer :protected_area_code
      t.integer :type_of_record
      t.integer :survey_code
      t.integer :housing_unit
      t.string :common_key

      t.timestamps
    end
end

end
