class AddMoreColumnsToElectionFundamentalIndicator < ActiveRecord::Migration[7.1]
  def change
    add_column :election_fundamental_indicators, :election_code, :string
    add_column :election_fundamental_indicators, :election_year, :string
    add_column :election_fundamental_indicators, :dep_cod, :string
    add_column :election_fundamental_indicators, :mun_cod, :string
    add_column :election_fundamental_indicators, :zone_cod, :string
    add_column :election_fundamental_indicators, :polling_cod, :string
    add_column :election_fundamental_indicators, :id_polling, :string
    add_column :election_fundamental_indicators, :polling_name, :string
    add_column :election_fundamental_indicators, :tables, :string
    add_column :election_fundamental_indicators, :distric, :string
    add_column :election_fundamental_indicators, :address, :string
    add_column :election_fundamental_indicators, :lat, :string
    add_column :election_fundamental_indicators, :lon, :string
    add_column :election_fundamental_indicators, :women, :string
    add_column :election_fundamental_indicators, :men, :string
    add_column :election_fundamental_indicators, :total, :string
    add_column :election_fundamental_indicators, :mayor, :string
    add_column :election_fundamental_indicators, :gobern, :string
    add_column :election_fundamental_indicators, :council, :string
    add_column :election_fundamental_indicators, :assembly, :string
    add_column :election_fundamental_indicators, :jal, :string
    add_column :election_fundamental_indicators, :table_cod, :string
    add_column :election_fundamental_indicators, :part_code, :string
    add_column :election_fundamental_indicators, :part_name, :string
    add_column :election_fundamental_indicators, :cand_code, :string
    add_column :election_fundamental_indicators, :cand_name, :string
  end
end
