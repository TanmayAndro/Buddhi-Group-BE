class RenamePollingColumnsInElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    rename_column :election_fundamental_indicators, :polling_code, :polling_station_code
    rename_column :election_fundamental_indicators, :polling_name, :polling_station_name
    rename_column :election_fundamental_indicators, :address, :polling_station_address
  end
end
