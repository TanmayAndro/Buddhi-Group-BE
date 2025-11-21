class AddNewPollingIdToElectionFundamentalIndicator < ActiveRecord::Migration[7.1]
  def change
    add_column :election_fundamental_indicators, :new_polling_id, :string
    remove_column :election_fundamental_indicators, :year, :integer
  end
end
