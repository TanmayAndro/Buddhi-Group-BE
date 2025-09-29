class CreatePollingStations < ActiveRecord::Migration[7.1]
  def change
    create_table :polling_stations do |t|
      t.integer :election_year
      t.string  :election_type
      t.string  :department_name
      t.string  :municipality_name
      t.string  :polling_station_name
      t.string  :district
      t.string  :district_code
      t.string :latitude
      t.string :longitude
      t.boolean :is_mayor_elected_at_this_station
      t.boolean :is_governor_elected_at_this_station
      t.boolean :is_municipal_council_elected
      t.boolean :is_department_assembly_elected
      t.boolean :is_local_administrative_board
      t.integer :total_number_of_election_type_at_the_station
      t.timestamps
    end
  end
end