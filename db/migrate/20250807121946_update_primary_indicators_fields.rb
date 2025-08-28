class UpdatePrimaryIndicatorsFields < ActiveRecord::Migration[7.1]
    def change
    rename_column :primary_indicators, :average_households, :average_household_size if column_exists?(:primary_indicators, :average_households)
    rename_column :primary_indicators, :umeployment_rate, :unemployment_rate if column_exists?(:primary_indicators, :umeployment_rate)

    # Add new columns
    add_column :primary_indicators, :sex_ratio, :decimal
    add_column :primary_indicators, :age_dependency_ratio, :decimal
    add_column :primary_indicators, :urbanization_rate, :decimal
    add_column :primary_indicators, :ethnic_composition, :jsonb, default: {}
    add_column :primary_indicators, :migration_rate, :decimal
    add_column :primary_indicators, :gross_enrollment_ratio, :decimal
    add_column :primary_indicators, :employment_to_population_ratio, :decimal
    add_column :primary_indicators, :female_headship_rate, :decimal
    add_column :primary_indicators, :access_to_improved_water_source, :decimal
    add_column :primary_indicators, :access_to_improved_sanitation_rate, :decimal
    add_column :primary_indicators, :electricity_access_rate, :decimal
    add_column :primary_indicators, :internet_access_rate, :decimal
  end
end
