class AddMunicipalityCodeToCrimes < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :municipality_code, :integer
  end
end
