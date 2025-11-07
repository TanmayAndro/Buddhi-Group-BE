class RemoveIdPollingFromElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    remove_column :election_fundamental_indicators, :id_polling, :string
  end
end
