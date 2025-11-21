class CreateNewVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :new_votes do |t|
      t.integer :election_year
      t.string  :election_code
      t.string  :election_description
      t.string  :electoral_process_code
      t.string  :electoral_process_description
      t.date    :election_date
      t.string  :corporation_code
      t.string  :corporation_name
      t.string  :popular_election_code
      t.string  :popular_election_description
      t.string  :constituency_code
      t.string  :constituency_description
      t.string  :citrep_code
      t.string  :citrep_description
      t.string  :department_code
      t.string  :department_name
      t.string  :municipality_code
      t.string  :municipality_name
      t.string  :voting_zone_code
      t.string  :polling_station_code
      t.string  :polling_station_name
      t.string  :commune_code
      t.string  :commune_description
      t.string  :polling_table_code
      t.integer :number_of_votes_recorded
      t.string  :political_party_code
      t.string  :political_party_name
      t.string  :candidate_code
      t.string  :candidate_name
      t.string  :polling_id
      t.string  :updated_candidate_list
      t.string  :new_polling_id
      t.string  :voting_round

      t.timestamps
    end
  end
end
