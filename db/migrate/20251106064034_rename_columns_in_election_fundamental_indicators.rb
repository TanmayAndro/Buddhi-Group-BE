class RenameColumnsInElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
   def change
    rename_column :election_fundamental_indicators, :dep_cod, :department_code
    rename_column :election_fundamental_indicators, :mun_cod, :municipality_code
    rename_column :election_fundamental_indicators, :zone_cod, :zone_code
    rename_column :election_fundamental_indicators, :polling_cod, :polling_code
    rename_column :election_fundamental_indicators, :table_cod, :table_code
    rename_column :election_fundamental_indicators, :part_code, :political_party_code
    rename_column :election_fundamental_indicators, :part_name, :political_party_name
    rename_column :election_fundamental_indicators, :cand_code, :candidate_code
    rename_column :election_fundamental_indicators, :cand_name, :candidate_name
  end
end
