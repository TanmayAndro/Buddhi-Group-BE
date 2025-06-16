class AddArtCrimeToCrime < ActiveRecord::Migration[7.1]
  def change
    add_column :crimes, :art_crime, :string #ART_DELITO
  end
end
