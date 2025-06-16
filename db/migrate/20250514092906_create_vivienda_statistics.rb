class CreateViviendaStatistics < ActiveRecord::Migration[7.1]
  def change
    create_table :primary_indicators do |t|
      t.integer :muncipality_code
      t.integer :department_code
      t.decimal :average_households
      t.json :percent_of_dwelling_type, default: {}
      t.decimal :percent_of_water_supply_access
      t.decimal :percent_of_sewage_access
      t.decimal :percent_of_electricity_access
      t.decimal :percent_of_internet_access
      t.decimal :percent_of_gas_connected
      t.decimal :percent_of_waste_collection
      t.decimal :average_house_hold_size
      t.decimal :percent_of_house_holds
      t.decimal :percent_of_female_headship
      t.decimal :masculnity_ratio
      t.decimal :feminity_ratio 
      t.decimal :demographic_dependency_ratio
      t.decimal :aging_index 
      t.decimal :youth_index
      t.decimal :child_woman_ratio
      t.decimal :population_density 
      t.json    :distribution_in_geographic_areas, default: {}
      t.json    :population_distribution_by_ethnic_and_cultural, default: {}
      t.json    :population_by_place_of_birth, default: {}
      t.decimal :literacy_rate_over_15 
      t.decimal :school_attendance_rate
      t.decimal :person_with_difficulties
      t.decimal :economically_active_population 
      t.decimal :umeployment_rate
      t.decimal :infant_mortality_rate
      t.decimal :fertility_rate
      t.decimal :life_expectancy_at_birth
      t.decimal :housing_tenure_status

      t.timestamps
    end
  end
end
