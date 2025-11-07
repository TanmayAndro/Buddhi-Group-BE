class CreateElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    create_table :election_fundamental_indicators do |t|
      t.integer :total_ballots_cast
      t.integer :valid_votes
      t.integer :blank_votes
      t.integer :null_votes
      t.integer :unmarked_votes
      t.integer :year
      t.integer :polling_code
      t.jsonb :candidate_results 
    end
  end
end
