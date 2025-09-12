class AddColumnsToGeoReferenciacions < ActiveRecord::Migration[7.1]
  def change
    add_column :unique_georreferenciacions, :department, :string
    add_column :unique_georreferenciacions, :municipality, :string
  end
end
