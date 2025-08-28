class RenameAndAddFieldsToFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    # Rename existing columns if they map directly
    rename_column :fundamental_indicators, :total_population, :total_person
    rename_column :fundamental_indicators, :children_under_five, :children_count
    rename_column :fundamental_indicators, :over_fifteen, :adult_count
    rename_column :fundamental_indicators, :over_sixty_four, :senior_citizen_count
    rename_column :fundamental_indicators, :total_dwellings, :dwelling_count
    rename_column :fundamental_indicators, :total_house_holds, :house_hold_count

    # Add new fields
    add_column :fundamental_indicators, :urban_population_count, :integer
    add_column :fundamental_indicators, :adult_literacy_count, :integer
    add_column :fundamental_indicators, :school_attendance_count, :integer
    add_column :fundamental_indicators, :total_population_for_schooling, :integer
    add_column :fundamental_indicators, :school_population, :jsonb
    add_column :fundamental_indicators, :employment_count, :integer
    add_column :fundamental_indicators, :unemployment_count, :integer
    add_column :fundamental_indicators, :total_population_for_work, :integer
    add_column :fundamental_indicators, :working_age_count, :integer
    add_column :fundamental_indicators, :senitation_house_count, :integer
    add_column :fundamental_indicators, :electricity_house_count, :integer
    add_column :fundamental_indicators, :house_holds_with_internet, :integer
    add_column :fundamental_indicators, :ethnic_group_population, :jsonb
    add_column :fundamental_indicators, :live_births_count, :integer
    add_column :fundamental_indicators, :reproductivity_women_no, :integer
    add_column :fundamental_indicators, :number_of_infant_deaths, :integer
  end
end
