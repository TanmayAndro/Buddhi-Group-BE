class RemoveSomeColumnsFromPrimaryIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_column :primary_indicators, :muncipality_code, :integer
    remove_column :primary_indicators, :department_code, :integer
    remove_column :primary_indicators, :percent_of_dwelling_type, :json
    remove_column :primary_indicators, :percent_of_water_supply_access, :decimal
    remove_column :primary_indicators, :percent_of_sewage_access, :decimal
    remove_column :primary_indicators, :percent_of_electricity_access, :decimal
    remove_column :primary_indicators, :percent_of_internet_access, :decimal
    remove_column :primary_indicators, :percent_of_gas_connected, :decimal
    remove_column :primary_indicators, :percent_of_waste_collection, :decimal
    remove_column :primary_indicators, :average_house_hold_size, :decimal
    remove_column :primary_indicators, :percent_of_house_holds, :decimal
    remove_column :primary_indicators, :percent_of_female_headship, :decimal
    remove_column :primary_indicators, :masculnity_ratio, :decimal
    remove_column :primary_indicators, :feminity_ratio, :decimal
    remove_column :primary_indicators, :demographic_dependency_ratio, :decimal
    remove_column :primary_indicators, :aging_index, :decimal
    remove_column :primary_indicators, :youth_index, :decimal
    remove_column :primary_indicators, :child_woman_ratio, :decimal
    remove_column :primary_indicators, :distribution_in_geographic_areas, :json
    remove_column :primary_indicators, :population_distribution_by_ethnic_and_cultural, :json
    remove_column :primary_indicators, :population_by_place_of_birth, :json
    remove_column :primary_indicators, :school_attendance_rate, :decimal
    remove_column :primary_indicators, :person_with_difficulties, :decimal
    remove_column :primary_indicators, :economically_active_population, :decimal
  end
end
