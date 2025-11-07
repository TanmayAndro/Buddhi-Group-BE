class AddTimestampsToElectionFundamentalIndicators < ActiveRecord::Migration[7.1]
  def change
    add_timestamps :election_fundamental_indicators, default: -> { 'CURRENT_TIMESTAMP' }, null: false
  end
end
