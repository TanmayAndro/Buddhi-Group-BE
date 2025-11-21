class CreateNewElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    create_table :new_election_fundamental_indicators do |t|
      t.integer :total_ballots_cast
      t.integer :valid_votes
      t.integer :blank_votes
      t.integer :null_votes
      t.integer :unmarked_votes
      t.string  :polling_id
      t.jsonb   :candidate_results
      t.string  :election_code
      t.string  :election_year
      t.string  :department_code
      t.string  :municipality_code
      t.string  :zone_code
      t.string  :polling_station_code
      t.string  :polling_station_name
      t.string  :tables
      t.string  :distric
      t.string  :polling_station_address
      t.string  :lat
      t.string  :lon
      t.string  :women
      t.string  :men
      t.string  :total
      t.string  :mayor
      t.string  :gobern
      t.string  :council
      t.string  :assembly
      t.string  :jal
      t.string  :table_code
      t.string  :political_party_code
      t.string  :political_party_name
      t.string  :candidate_code
      t.string  :candidate_name
      t.string  :new_polling_id
      t.string :voting_round
      t.timestamps
    end
  end
end
