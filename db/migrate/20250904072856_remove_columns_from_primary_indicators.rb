class RemoveColumnsFromPrimaryIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_column :primary_indicators, :population_density, :float
    remove_column :primary_indicators, :life_expectancy_at_birth, :float
    remove_column :primary_indicators, :housing_tenure_status, :string
    remove_column :primary_indicators, :female_headship_rate, :float
  end
end
