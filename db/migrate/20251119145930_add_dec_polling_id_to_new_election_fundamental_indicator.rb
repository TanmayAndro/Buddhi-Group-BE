class AddDecPollingIdToNewElectionFundamentalIndicator < ActiveRecord::Migration[7.1]
  def change
    add_column :new_election_fundamental_indicators, :dec_polling_id, :string
  end
end
