class RenamePollingCodeToPollingIdInElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    rename_column :election_fundamental_indicators, :polling_code, :polling_id
    change_column :election_fundamental_indicators, :polling_id, :string
  end
end
