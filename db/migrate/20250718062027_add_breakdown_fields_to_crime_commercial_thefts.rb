class AddBreakdownFieldsToCrimeCommercialThefts < ActiveRecord::Migration[7.1]
  def change
    add_column :crime_commercial_thefts, :age_group, :string
    add_column :crime_commercial_thefts, :gender, :string
    add_column :crime_commercial_thefts, :weapons_types, :string
  end
end
