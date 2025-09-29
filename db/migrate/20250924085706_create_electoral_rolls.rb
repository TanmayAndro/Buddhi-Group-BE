class CreateElectoralRolls < ActiveRecord::Migration[7.1]
  def change
    create_table :electoral_rolls do |t|
      t.integer :election_year
      t.string  :election_type
      t.string  :department_code
      t.string  :municipality_code
      t.string  :voting_zone_code
      t.string  :polling_station_code
      t.string  :department_name
      t.string  :municipality_name
      t.string  :polling_station_name
      t.integer :women
      t.integer :men
      t.integer :total
      t.integer :total_polling_tables_at_station
      t.string  :district
      t.string  :polling_station_address

      t.timestamps
    end
  end
end

